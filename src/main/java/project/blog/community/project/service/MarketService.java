package project.blog.community.project.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import project.blog.community.project.common.Page;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.dto.request.MarketRateRequestDTO;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.MarketDetailResponse;
import project.blog.community.project.dto.response.MarketGetAddFavListResponseDTO;
import project.blog.community.project.dto.response.MarketListResponseDTO;
import project.blog.community.project.dto.response.ReplyListResponseDTO;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;
import project.blog.community.project.entity.Rate;
import project.blog.community.project.mapper.MarketMapper;


import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor

public class MarketService {
    private final MarketMapper mapper;


    public List<MarketListResponseDTO> getList(HttpServletRequest request) {
        List<MarketListResponseDTO> dtoList = new ArrayList<>();

        HttpSession session = request.getSession();
        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);

        // 내가 즐겨찾기한 리스트
        List<Integer> boards = mapper.checkFav(currentLoginMemberAccount);

        List<Market> marketList = mapper.findAll();
        for (Market market : marketList){
            MarketListResponseDTO dto = new MarketListResponseDTO(market, boards);
            dtoList.add(dto);
        }
        return dtoList;
    }




    //즐겨찾기만 호출 하는 리스트
    public List<MarketGetAddFavListResponseDTO> getAddFavListService(String currentLoginMemberAccount) {
        List<MarketGetAddFavListResponseDTO> addFavDTOList = new ArrayList<>();

        // 내가 즐겨찾기한 리스트
        List<Integer> boards = mapper.selectByAccountNumber(currentLoginMemberAccount);

        return addFavDTOList;
    }



//    //페이지 처리
//    @GetMapping("/{boardNo}/page/{pageNo}")
//    public ResponseEntity<?> list(@PathVariable int boardNo, @PathVariable int pageNo) {
//        log.info("api/v1/replies{}: GET!!!", boardNo);
//        log.info("pageNo: {}", pageNo);
//
//        Page page = new Page();
//        page.setPageNo(pageNo);
//        page.setAmount(5);
//
//        ReplyListResponseDTO replies = replyService.getList(boardNo, page);
//
//        return ResponseEntity.ok().body(replies);
//    }


    public void modify(MarketModifyRequestDTO dto, String currentLoginMemberAccount) {
        Market marketContent = dto.toEntity();

        mapper.modify(marketContent, currentLoginMemberAccount);
    }

    public void register(MarketWriteRequestDTO dto, String filePath, String currentLoginMemberAccount) {
        Market market = new Market(dto, filePath, currentLoginMemberAccount);//DTO -> Entity
//        market.setTextWriter(MarketUtils.getCurrentLoginMemberAccount(session));
        market.setFile(filePath);
        mapper.save(market);
    }




    public MarketDetailResponse getDetail(int boardNo) {
        mapper.updateViewCount(boardNo);
        Market market = mapper.findOne(boardNo);
        return new MarketDetailResponse(market);
    }

    public void delete(int boardNo) {
        mapper.delete(boardNo);
    }

//    public List<Board> addFavList(int boardNo, boolean addFav) {
//        return mapper.addFavList(boardNo, addFav);
//    }

    public void updateFav(int boardNo,
                          HttpSession session,
                          String isAddFav) {

        session.getAttribute("login");
        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);

        Favorite favorite = Favorite.builder()
                .accountNumber(currentLoginMemberAccount)
                .boardNo(boardNo)
                .build();

        if (isAddFav.equals("true")) {
            mapper.addFav(favorite);
        } else {
            mapper.removeFav(favorite);
        }
    }

    public void addRate(MarketRateRequestDTO dto) {
        String textWriter = dto.getTextWriter(); //재가공

        // User 테이블 rate 컬럼 1 추가
        mapper.updateRateBoard(textWriter);

        // Market Rate 테이블(중복 검사를 위한 테이블) row 추가
        mapper.addRate(dto);
    }

    public int getRate(String textWriter) {
        return mapper.checkRate(textWriter);
    }

    public boolean isDuplication(MarketRateRequestDTO dto) {
        Rate rate = mapper.checkRateRelation(dto);
        if (rate == null) return false; //중복X
        else return true; //중복됨

    }


}
