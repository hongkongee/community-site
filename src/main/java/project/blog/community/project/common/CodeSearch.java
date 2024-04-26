package project.blog.community.project.common;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
@EqualsAndHashCode
public class CodeSearch extends MyCodePage {

    // 검색 조건, 검색어
    private String type, keyword;

    public CodeSearch() {
        this.type = "";
        this.keyword = "";
    }
}
