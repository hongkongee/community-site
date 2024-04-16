package project.blog.community.project.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.request.ClaimRequestDTO;

import java.util.List;

@Service
@Slf4j
public class ManagementService {
    public void report(ClaimRequestDTO dto) {
        List<String> reportList = dto.getInterests(); // 신고 사유 (객관식)
        String message = dto.getMessage(); // 신고 사유 (서술형)

    }
}
