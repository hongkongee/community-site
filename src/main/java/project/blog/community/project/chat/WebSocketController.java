package project.blog.community.project.chat;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebSocketController {

    @GetMapping("/chat/chat")
    public String index() {
        return "chat/chat";
    }

}
