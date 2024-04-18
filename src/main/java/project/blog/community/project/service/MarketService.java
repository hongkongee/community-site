package project.blog.community.project.service;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.common.marketSearch;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.dto.request.MarketWriteRequestDTO;
import project.blog.community.project.dto.response.MarketListResponseDTO;
import project.blog.community.project.entity.Market;
import project.blog.community.project.mapper.MarketMapper;


import java.util.ArrayList;
import java.util.List;

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
}
