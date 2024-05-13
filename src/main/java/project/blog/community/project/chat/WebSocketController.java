package project.blog.community.project.chat;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
public class WebSocketController {

    @GetMapping("/chat/chat")
    public String index() {
        return "chat/chat";
    }

}
