package project.blog.community.project.common;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.core.annotation.MergedAnnotations;

@Setter @Getter @ToString
@EqualsAndHashCode
public class marketSearch {

    private String type, keyword;

    public marketSearch(){
        this.type = "";
        this.keyword = "";
    }

}
