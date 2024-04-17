package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.MarketModifyRequestDTO;
import project.blog.community.project.entity.Market;
import project.blog.community.project.mapper.MarketMapper;

@Service
@RequiredArgsConstructor


public class MarketService {
    private final MarketMapper mapper;
    public void modify(MarketModifyRequestDTO dto) {
        Market marketContent = dto.toEntity();
        mapper.modify(marketContent);
    }
}
