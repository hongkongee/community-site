package project.blog.community.project.common;

import lombok.*;

@Setter @Getter @ToString
public class Search  extends Page {

    private String type, keyword;

    public Search() {

        this.type = "";
        this.keyword = "";

    }

}
