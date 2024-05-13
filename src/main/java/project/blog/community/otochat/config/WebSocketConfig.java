package project.blog.community.otochat.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.standard.ServletServerContainerFactoryBean;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import java.util.logging.SocketHandler;

/*
    핸들러를 이용하여 웹소켓을 활성화 하기 위한 설정 클래스
    프로토콜은 wss:// 사용 (ws보다 신뢰성이 좋고 TSL이라는 보안 계층을 통과해 전달되므로
    송신자 측에서 데이터가 암호화되고 복호화는 수신자 측에서 이뤄진다.
    -> 프락시 서버는 패킷 내부를 볼 수 없다.
    
    
 */

@Configuration
@EnableWebSocket
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    SocketHandler socketHandler;

    // 요청은 핸들러로 라우트 되고
    // beforeHandshake메소드에서 헤더 중 필요한 값을 가져와 true값 반환하면 Upgrade 헤더와 함께 101 Switching Protocols 상태 코드를 포함한 응답 반환
    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler((WebSocketHandler) socketHandler, "/wss/chat")
                .addInterceptors(new HttpSessionHandshakeInterceptor(), new CustomHandshakeInterceptor())
                .setAllowedOrigins("https:/~~/chatting/서버url");
    }
    // setAllowedOrigins : 도메인이 다른 서버에도 접속 가능하도록 CORS 추가
    //만약 CORS때문에 origin에서 403에러가 뜬다면
    //String[] origins = {"https://www.url1.com", "https://m.url2.com", "https://url3.com"}; 이렇게 여러개의 origin들을 setAllowedOrigins에 대입해도 됨

    @Bean
    public ServletServerContainerFactoryBean createWebSocketContainer() {
        ServletServerContainerFactoryBean container = new ServletServerContainerFactoryBean();
        container.setMaxBinaryMessageBufferSize(500000);
        container.setMaxTextMessageBufferSize(500000);
        return container;
    }
}
