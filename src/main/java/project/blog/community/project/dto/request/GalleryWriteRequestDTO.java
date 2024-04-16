package project.blog.community.project.dto.request;

import lombok.*;

import java.util.Date;

@Setter
@Getter@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
public class GalleryWriteRequestDTO {

private String user;
private String title;
private String photoLink;


}
