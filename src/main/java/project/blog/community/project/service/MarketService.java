package project.blog.community.project.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.marketSearch;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.MarketDetailResponse;
import project.blog.community.project.dto.response.MarketListResponseDTO;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Favorite;
import project.blog.community.project.entity.Market;
import project.blog.community.project.mapper.MarketMapper;
import project.blog.community.util.LoginUtils;


import java.util.ArrayList;
import java.util.List;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@Service
@RequiredArgsConstructor

public class MarketService {
    private final MarketMapper mapper;


    public List<MarketListResponseDTO> getList() {
        List<MarketListResponseDTO> dtoList = new ArrayList<>();

        List<Market> marketList = mapper.findAll();
        for (Market market : marketList){
            MarketListResponseDTO dto = new MarketListResponseDTO(market);
            dtoList.add(dto);
        }
        return dtoList;

    }


    public void modify(MarketModifyRequestDTO dto) {
        Market marketContent = dto.toEntity();
        mapper.modify(marketContent);
    }

    public void register(MarketWriteRequestDTO dto) {
        Market market = new Market(dto); //DTO -> Entity
//        market.setTextWriter(MarketUtils.getCurrentLoginMemberAccount(session));
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

/*    public List<Board> getFavList(int boardNo, boolean addFav) {
//        return mapper.addFavList(boardNo, addFav);
    }*/

//    public void updateFav(int boardNo, HttpServletRequest request) {
//
//        HttpSession session = request.getSession();
//        session.getAttribute("login");
//        // 세션 유틸리티 메서드로 로그인한 유저 ID 가져오기
//        String currentLoginMemberAccount = getCurrentLoginMemberAccount(session);
//
//        Favorite favorite = Favorite.builder()
//                .accountNumber(currentLoginMemberAccount)
//                .boardNo(boardNo)
//                .build();
//
//        mapper.addFav(favorite);
//    }
}
