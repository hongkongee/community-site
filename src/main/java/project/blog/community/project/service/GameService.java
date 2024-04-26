package project.blog.community.project.service;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.RpsRequestDTO;
import project.blog.community.project.mapper.UserMapper;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Random;

import static project.blog.community.project.service.GameResult.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class GameService {

    private final UserMapper userMapper;

    public String rpsPointCalc(RpsRequestDTO dto, String myAccount) {
        // 1. 내 포인트에서 베팅 금액 차감
        // DB에서 로그인한 대상 (session) 의 포인트 차감
        int bettingPoint = dto.getBetPoint();
        userMapper.addPoint(myAccount, -bettingPoint);
        
        // 2. 가위바위보 진행 (컴퓨터 랜덤 가위바위보 생성 후 비교) -> GameResult enum 타입의 결과
        GameResult gameResult = rpsWithComputer(dto.getChoice());

        // 3. 가위바위보 결과에 따라 포인트 지급 or 차감
        int resultPoint = calcPoint(bettingPoint, gameResult);
        // DB에서 로그인한 대상 (session) 의 포인트 지급 or 차감
        userMapper.addPoint(myAccount, resultPoint);

        // 4. 결과를 화면단에 전달, 결과에 따라 화면을 다르게 구성 -> "ROCK", "SCISSOR", "PAPER" String
        String gameResultString = gameResult.name();
        return gameResultString;
    }

    private int calcPoint(int bettingPoint, GameResult gameResult) {
        return switch (gameResult) {
            case WIN -> bettingPoint * 2; // 원금의 2배

            case LOSE -> 0; // 차감한 금액에서 안돌려줌

            case DRAW -> bettingPoint; // 원금 반환
        };
    }


    // 가위바위보 진행
    private GameResult rpsWithComputer(String choice) {
        Random random = new Random();
        int i = random.nextInt(3) + 1;
        String computerChoice = switch (i) {
            case 1 -> "rock";
            case 2 -> "paper";
            case 3 -> "scissors";
            default -> "error";
        };

        GameResult gameResult;


        if (choice.equals("rock")) {
            if (computerChoice.equals("rock")) gameResult = DRAW;
            else if (computerChoice.equals("scissors")) gameResult = WIN;
            else gameResult = LOSE;

        } else if (choice.equals("scissors")) {
            if (computerChoice.equals("rock")) gameResult = LOSE;
            else if (computerChoice.equals("scissors")) gameResult = DRAW;
            else gameResult = WIN;

        } else { // paper
            if (computerChoice.equals("rock")) gameResult = WIN;
            else if (computerChoice.equals("scissors")) gameResult = LOSE;
            else gameResult = DRAW;
        }

        return gameResult;


    }


    // 랜덤으로 오늘 포인트 증가시키기
    public int todayRandomPoint(String myAccount, HttpServletResponse response) {

        // 쿠키 만들기
        Cookie cookie = new Cookie("pp", myAccount); // account 필드가 쿠키의 저장 값

        cookie.setMaxAge(calcTimeDifference()); // 쿠키 수명 = 다음날 자정까지
        log.info("time difference : " + calcTimeDifference());
        cookie.setPath("/"); // 쿠키가 모든 경로에서 유효

        response.addCookie(cookie); // 응답 객체에 쿠키를 태워서 클라이언트로 전송

        // 랜덤으로 지급할 포인트 값 가져오기 (0 ~ 500 P 범위)
        Random random = new Random();
        int randomInt = random.nextInt(10);
        int todayPoint = randomInt * 50;

        log.info("my Account : " + myAccount);
        log.info("random point : " + todayPoint);

        userMapper.addPoint(myAccount, todayPoint);
        return todayPoint;

    }

    // 현재시간에서 다음날 자정 사이의 시간(초단위) 구하기
    private int calcTimeDifference() {
        // Get the current date and time
        LocalDateTime currentTime = LocalDateTime.now();

        // Get midnight of the next day
        LocalDateTime midnightNextDay = LocalDateTime.of(
                currentTime.toLocalDate().plusDays(1),
                LocalTime.MIDNIGHT
        );

        // Calculate the duration between the current time and midnight of the next day
        Duration duration = Duration.between(currentTime, midnightNextDay);

        // Get the time difference in seconds
        return (int) duration.getSeconds();
    }

}
