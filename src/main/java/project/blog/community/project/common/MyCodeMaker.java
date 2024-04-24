package project.blog.community.project.common;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;

@Getter@ToString
@EqualsAndHashCode
public class MyCodeMaker {
    private int begin,end, finalPage;

    private boolean prev, next;
    private MyCodePage page;

    private int totalCount;


    public MyCodeMaker(MyCodePage page, int totalCount) {
        this.page = page;
        this.totalCount = totalCount;

        makePageInfo();

    }

    private static final  int PAGE_COUNT = 10;

    private void makePageInfo() {
        this.end = (int) (Math.ceil((double) page.getPageNo() / PAGE_COUNT) * PAGE_COUNT);
        this.begin = end - PAGE_COUNT + 1;
        this.prev = begin > 1;
        this.finalPage = (int) Math.ceil((double) totalCount / page.getAmount());

        if (this.finalPage < this.end){
            this.end = this.finalPage;
        }

        this.next = this.end < this.finalPage;

    }
}
