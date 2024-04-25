package project.blog.community.project.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface LikeMapper {
    // 좋아요 추가
    public void addLike(@Param("accountNumber") String currentLoginMemberAccount, @Param("bno") int bno);

    // 좋아요 삭제
    public void deleteLike(@Param("accountNumber") String currentLoginMemberAccount, @Param("bno") int bno);

    int checkLike(@Param("accountNumber") String myAccount, @Param("bno") int bno);
}
