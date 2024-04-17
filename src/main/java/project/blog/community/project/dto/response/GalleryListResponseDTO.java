package project.blog.community.project.dto.response;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.ToString;
import project.blog.community.project.entity.Gallery;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter @ToString @EqualsAndHashCode
public class GalleryListResponseDTO {

    private final int photoNumber;
    private final String shortTitle;
    private final String regDate;
    private final String writer;

//    public GalleryListResponseDTO(Gallery gallery) {
//        this.PhotoNumber = gallery.getPhotoNumber();
//        this.shortTitle = makeShortTitle(gallery.getTitle());
//
//        this.regDate = makePrettierDateString(gallery.getRegDate());
//        this.writer = gallery.getUser();
//    }
public GalleryListResponseDTO(Gallery gallery) {
    this.photoNumber = gallery.getPhotoNumber();
    this.shortTitle = (gallery.getTitle() != null) ? makeShortTitle(gallery.getTitle()) : null;
    this.regDate = makePrettierDateString(gallery.getRegDate());
    this.writer = gallery.getUser();
}

    private String makePrettierDateString(LocalDateTime regDate) {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        return dtf.format(regDate);
    }

   private String makeShortTitle(String title) {
        return sliceString(title,5);
    }
    private static String sliceString(String targetString, int wishLength) {
        return (targetString.length() > wishLength)
                ? targetString.substring(0, wishLength) + "..."
                : targetString
                ;
    }

}
