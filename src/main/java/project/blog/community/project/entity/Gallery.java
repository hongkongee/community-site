package project.blog.community.project.entity;

import lombok.*;
import project.blog.community.project.dto.request.GalleryWriteRequestDTO;

import java.time.LocalDateTime;


import java.time.LocalDateTime;

/*
create table Gallery(
photoNumber int not null,
user varchar(30) not null,
reg_Date date not null,
photoLink varchar(100) not null
);
 */
@Setter@Getter @ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class Gallery {
private int PhotoNumber;
private String user;
private LocalDateTime regDate;//작성일자
private String photoLink; //이미지
private String title;

    public Gallery(GalleryWriteRequestDTO dto) {
        this.user = dto.getUser();
    this.regDate = LocalDateTime.now();
        this.photoLink = dto.getPhotoLink();

        this.title = dto.getTitle();

    }
}
