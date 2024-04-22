package project.blog.community.project.entity;

/*
* CREATE TABLE tbl_follow (
    following VARCHAR(50),
	follower VARCHAR(50),
    UNIQUE (following, follower)
);
* */
import lombok.*;

@Setter
@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Follow {
    private String following;
    private String follower;
}












































