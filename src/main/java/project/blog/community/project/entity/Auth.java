package project.blog.community.project.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

@AllArgsConstructor
@Getter @ToString
public enum Auth {

   COMMON ("일반", 1),
   ADMIN ("관리자", 2);

   private String description;
   private int authNumber;



}



























































