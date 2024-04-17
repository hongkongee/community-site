package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import project.blog.community.project.entity.Board;
import project.blog.community.project.entity.Market;
import project.blog.community.project.entity.Reply;

@Mapper
public interface MarketMapper {
    void save(Market board);
    void modify(Market market);

}
