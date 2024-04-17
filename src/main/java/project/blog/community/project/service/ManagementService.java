package project.blog.community.project.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.ReportRequestDTO;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.BoardMapper;
import project.blog.community.project.mapper.UserMapper;

import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class ManagementService {

    private final UserMapper userMapper;
    private final BoardMapper boardMapper;

    public void report(ReportRequestDTO dto) {
        int bno = dto.getBno(); // 신고 게시글 번호
        String writer = dto.getWriter(); // 신고 게시글 작성자
        List<String> reportList = dto.getInterests(); // 신고 사유 (객관식)
        String message = dto.getMessage(); // 신고 사유 (서술형)

        // 게시글 tbl_board report_count +1
        boardMapper.updateReportCount(bno);

        // 유저 tbl_user report +1
        userMapper.updateReport(writer);// writer은 user의 account에 해당

        // 신고 내용을 따로 DB(tbl_report)에 저장?

    }

    // 관리자가 3회 이상 신고를 받은 게시물, 5회 이상 신고를 받은 유저를 조회 및 삭제가 가능
//    public void deleteUser()
}
