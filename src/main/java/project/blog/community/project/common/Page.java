package project.blog.community.project.common;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class Page {

   private int pageNo;
   private int amount;

   public Page() {
      this.pageNo = 1;
      this.amount = 6;
   }

   public int getPageStart() {
      return (pageNo - 1) * amount;
   }


}












































