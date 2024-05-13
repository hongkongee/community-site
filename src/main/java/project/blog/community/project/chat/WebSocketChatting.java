package project.blog.community.project.chat;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import project.blog.community.project.dto.response.LoginUserResponseDTO;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import java.util.Date;

import static project.blog.community.util.LoginUtils.getCurrentLoginMemberAccount;

@ServerEndpoint(value = "/chatt", configurator = WebSocketConfig.class)
@Service
public class WebSocketChatting {


    private static Set<Session> CLIENTS = Collections.synchronizedSet(new HashSet<>());

    private class User {
        Session session;
        String key;
    }

    @OnOpen
    public void onOpen(Session session) throws Exception {
        System.out.println(session.toString());

        if (CLIENTS.contains(session)) {
            System.out.println("이미 연결된 세션입니다. > " + session);
        } else {
            CLIENTS.add(session);
            System.out.println("새로운 세션입니다. > " + session);

            // 채팅방에 들어온 유저의 아이디 가져오기
            String userId = (String) session.getUserProperties().get("loginAccount");
            
            // 입장 메세지 생성하기
            String enterMsg = enterMessage(session);

            try {
//                session.getBasicRemote().sendText(enterMsg); 나 자신에게만 메세지 전송
                for (Session client : CLIENTS) {
                    System.out.println("모두에게 메세지를 전달합니다. > " + enterMsg);
                    client.getBasicRemote().sendText(enterMsg); // 채팅 참여자 모두에게 메세지 전송
                }
            } catch (IOException e) {
                e.printStackTrace();
            }

        }
    }

    @OnClose
    public void onClose(Session session) throws Exception {
        CLIENTS.remove(session);
        System.out.println("세션을 닫습니다. : " + session);
    }

    @OnMessage
    public void onMessage(String message, Session session) throws Exception {
        System.out.println("입력된 메세지입니다. > " + message);

        for (Session client : CLIENTS) {
            System.out.println("메세지를 전달합니다. > " + message);
            client.getBasicRemote().sendText(message);
        }
    }

    // 입장 메세지 만들기
    public String enterMessage(Session session) throws Exception {

        // 현재 날짜 데이터 만들기
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy. M. d. a h:mm:ss", Locale.KOREA);
        String formattedDate = sdf.format(now);


        String userName = (String) session.getUserProperties().get("loginName");
        System.out.println("user ID is " + userName);


        String mid = "enterMsg";
        String msg = userName + "님이 입장하셨습니다.";
        String enterMsg = String.format("{\"mid\":\"%s\",\"msg\":\"%s\",\"date\":\"%s\"}", mid, msg, formattedDate);
//        System.out.println("입장 메세지입니다. > " + enterMsg);
        return enterMsg;
    }

}
