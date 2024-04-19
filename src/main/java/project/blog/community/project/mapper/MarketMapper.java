package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.common.marketSearch;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Market;
import project.blog.community.project.entity.Reply;

import java.util.List;

@Mapper
public interface MarketMapper {
    void save(Market market);
    void modify(Market market);

    List<Market> findAll();
    void updateViewCount(int boardNo);

    Market findOne(int boardNo);
}
