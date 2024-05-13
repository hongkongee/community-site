package project.blog.community.otochat.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Map;
// 소켓이 연결될 때 작업을 수행
public class CustomHandshakeInterceptor implements HandshakeInterceptor {
    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, WebSocketHandler wsHandler, Map<String, Object> attributes) {
        ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
        HttpServletRequest req = servletRequest.getServletRequest();
        HttpSession httpSession = req.getSession();
        String sessionID = httpSession.getId();
        attributes.put("sessionID", sessionID);

        String userName = req.getParameter("userName");

        attributes.put("userName", userName);


        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest request,
                               ServerHttpResponse response, WebSocketHandler wsHandler, Exception ex) {
    }
}
