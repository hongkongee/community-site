package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.RpsRequestDTO;
import project.blog.community.project.mapper.UserMapper;

import java.util.Random;

import static project.blog.community.project.service.GameResult.*;

@Service
@RequiredArgsConstructor
public class GameService {

    private UserMapper userMapper;

    public String rpsPointCalc(RpsRequestDTO dto, String myAccount) {
        // 1. 내 포인트에서 베팅 금액 차감
        // DB에서 로그인한 대상 (session) 의 포인트 차감
        int bettingPoint = dto.getBetPoint();
        userMapper.addPoint(myAccount, -bettingPoint);
        
        // 2. 가위바위보 진행 (컴퓨터 랜덤 가위바위보 생성 후 비교)
        GameResult gameResult = rpsWithComputer(dto.getChoice());

        // 3. 가위바위보 결과에 따라 포인트 지급 or 차감
        int resultPoint = calcPoint(bettingPoint, gameResult);
        // DB에서 로그인한 대상 (session) 의 포인트 지급 or 차감
        userMapper.addPoint(myAccount, resultPoint);

        // 4. 결과를 화면단에 전달, 결과에 따라 화면을 다르게 구성
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
    public int todayRandomPoint(String myAccount) {
        Random random = new Random();
        int randomInt = random.nextInt(10);
        int todayPoint = randomInt * 50;

        userMapper.addPoint(myAccount, todayPoint);
        return todayPoint;

    }
}
