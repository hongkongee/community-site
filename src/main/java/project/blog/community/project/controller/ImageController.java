package project.blog.community.project.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@RestController
@RequestMapping("/display")
@Slf4j
@RequiredArgsConstructor
public class ImageController {

    // rootPath = "C:/MyWorkspace/pictures/"
    @Value("${file.upload.root-path}")
    private String rootPath;

    // 이미지 출력하기
    @GetMapping("/{y}/{m}/{d}/{fileName}")
    public ResponseEntity<?> displayImage(
            @PathVariable String y,
            @PathVariable String m,
            @PathVariable String d,
            @PathVariable String fileName
    ) {
        log.info("/display/{}/{}/{}/{}: GET!", y, m, d, fileName);

        String fullPath = String.format("%s/%s/%s/%s/%s", rootPath, y, m, d, fileName);
        log.info("fullPath: {}", fullPath);
        File file = new File(fullPath);

        ResponseEntity<byte[]> result = null;
        HttpHeaders headers = new HttpHeaders(); // 응답 헤더 객체 생성.

        try {
            // probeContentType: 매개값으로 전달받은 파일의 타입이 무엇인지를 문자열로 반환.
            headers.add("Content-Type", Files.probeContentType(file.toPath()));

            // ResponseEntity 객체에 전달하고자 하는 파일을 byte[]로 변환해서 전달. (파일의 손상을 막기 위해)
            // header 내용도 같이 포함, 응답 상태 코드도 원하는 형태로 전달 가능.
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), headers, HttpStatus.OK);

        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(e.getMessage());
        }

        return result;
    }





}
