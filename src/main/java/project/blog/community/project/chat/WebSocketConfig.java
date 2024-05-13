package project.blog.community.project.chat;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.HandshakeResponse;
import jakarta.websocket.server.HandshakeRequest;
import jakarta.websocket.server.ServerEndpointConfig;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.server.standard.ServerEndpointExporter;
import project.blog.community.project.dto.response.LoginUserResponseDTO;
import project.blog.community.project.entity.User;
import project.blog.community.project.mapper.UserMapper;

@Component
public class WebSocketConfig extends ServerEndpointConfig.Configurator {


    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        /*
                Spring에서 Bean은 싱글톤으로 관리되지만,
                @ServerEndpoint 클래스는 WebSocket이 생성될 때마다 인스턴스가 생성되고
                JWA에 의해 관리되기 때문에 Spring의 @Autowired가 설정된 멤버들이 초기화 되지 않습니다.
                연결해주고 초기화해주는 클래스가 필요합니다.
         */
        return new ServerEndpointExporter();
    }

    @Override
    public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
        HttpSession httpSession = (HttpSession) request.getHttpSession();
        if (httpSession != null) {
            LoginUserResponseDTO loginDto = (LoginUserResponseDTO) httpSession.getAttribute("login");
            String myName = loginDto.getName();
            String myAccount = loginDto.getAccountNumber();

            config.getUserProperties().put("loginName", myName);
            config.getUserProperties().put("loginAccount", myAccount); // Store user ID in WebSocket session properties
        } else {
            config.getUserProperties().put("loginAccount", "null.....");
            config.getUserProperties().put("loginName", "null name");
        }
    }

}
