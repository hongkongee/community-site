package project.blog.community.otochat.handler;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import project.blog.community.otochat.dto.ChatMessageRequestDto;
import project.blog.community.otochat.service.ChatMessageService;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

// 메세지를 핸들링하는 클래스
@Component
@Slf4j
@RequiredArgsConstructor
public class SocketHandler extends TextWebSocketHandler {
    List<HashMap<String, Object>> rls = new ArrayList<>(); //웹소켓 세션을 담아둘 리스트 ---roomListSessions
    static int fileUploadIdx = 0;
    static String fileUploadSession = "";

    private final ChatMessageService chatMessageService;
    private final AwsS3Service awsS3Service;

    // 클라이언트로부터 JSON 형태의 메세지를 받아서 처리
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        //메시지 발송
        String msg = message.getPayload(); //JSON형태의 String메시지를 받는다.
        JSONObject obj = jsonToObjectParser(msg); //JSON데이터를 JSONObject로 파싱한다.

        ChatMessageRequestDto chatMessageRequestDto = ChatMessageRequestDto.builder()
                .userName((String) obj.get("userName"))
                .msg((String) obj.get("msg"))
                .imageUrl(null)
                .roomNumber(Integer.parseInt((String)obj.get("roomNumber")))
                .build();
        chatMessageService.save(chatMessageRequestDto);

        String rN = (String) obj.get("roomNumber"); //방의 번호를 받는다.
        String msgType = (String) obj.get("type"); //메시지의 타입을 확인한다.
        HashMap<String, Object> temp = new HashMap<String, Object>();
        if(rls.size() > 0) {
            for(int i=0; i<rls.size(); i++) {
                String roomNumber = (String) rls.get(i).get("roomNumber"); //세션리스트의 저장된 방번호를 가져와서
                if(roomNumber.equals(rN)) { //같은값의 방이 존재한다면
                    temp = rls.get(i); //해당 방번호의 세션리스트의 존재하는 모든 object값을 가져온다.
                    fileUploadIdx = i;
                    fileUploadSession = (String) obj.get("sessionId");
                    break;
                }
            }
            if(!msgType.equals("fileUpload")) { //메시지의 타입이 파일업로드가 아닐때만 전송한다.
                //해당 방의 세션들만 찾아서 메시지를 발송해준다.
                for(String k : temp.keySet()) {
                    if(k.equals("roomNumber")) { //다만 방번호일 경우에는 건너뛴다.
                        continue;
                    }

                    WebSocketSession wss = (WebSocketSession) temp.get(k);
                    if(wss != null) {
                        try {
                            TextMessage textMessage = new TextMessage(obj.toJSONString());
                            wss.sendMessage(textMessage);

                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }


    @Override
    public void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
        //ByteBuffer형태의 페이로드로 웹소켓 메시지 저장
        ByteBuffer byteBuffer = message.getPayload();
        //byte[]로 변환
        byte[] bytes = new byte[byteBuffer.remaining()];
        byteBuffer.get(bytes);

        String fileName = "chatting"+ UUID.randomUUID()+".jpg";
        String contentType = "image/jpg";

        ByteArrayMultipartFile multipartFile = new ByteArrayMultipartFile(bytes, contentType, fileName);
        String dirName = "chatting_images";
        URL uploadedFileUrl = awsS3Service.upload(multipartFile, dirName);


        byteBuffer.position(0); //파일을 저장하면서 position값이 변경되었으므로 0으로 초기화한다.
        //파일쓰기가 끝나면 이미지를 발송한다.

        int roomNumber = (int) session.getAttributes().get("roomNumber");
        String userName = (String) session.getAttributes().get("userName");

        ChatMessageRequestDto chatMessageRequestDto = ChatMessageRequestDto.builder()
                .userName(userName)
                .msg("image")
                .imageUrl(uploadedFileUrl.toString())
                .roomNumber(roomNumber)
                .build();
        chatMessageService.save(chatMessageRequestDto);


        HashMap<String, Object> temp = rls.get(fileUploadIdx);
        for(String k : temp.keySet()) {
            if(k.equals("roomNumber")) {
                continue;
            }
            WebSocketSession wss = (WebSocketSession) temp.get(k);
            try {
                wss.sendMessage(new BinaryMessage(byteBuffer));
                //BinaryMessage 객체를 사용하여 이미지 데이터를 ByteBuffer로 변환한 후 각 세션에게 전송
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @SuppressWarnings("unchecked")
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //소켓 연결
        super.afterConnectionEstablished(session);
        boolean flag = false;
        String url = session.getUri().toString();
        String roomNumber = url.split("/chat/")[1];
        int idx = rls.size(); //방의 사이즈를 조사한다.
        if(rls.size() > 0) {
            for(int i=0; i<rls.size(); i++) {
                String rN = (String) rls.get(i).get("roomNumber");
                if(rN.equals(roomNumber)) {
                    flag = true;
                    idx = i;
                    break;
                }
            }
        }

        if(flag) { //존재하는 방이라면 세션만 추가한다.
            HashMap<String, Object> map = rls.get(idx);
            map.put(session.getId(), session);
        }else { //최초 생성하는 방이라면 방번호와 세션을 추가한다.
            HashMap<String, Object> map = new HashMap<String, Object>();
            map.put("roomNumber", roomNumber);
            map.put(session.getId(), session);
            rls.add(map);
        }

        //세션등록이 끝나면 발급받은 세션ID값의 메시지를 발송한다.
        JSONObject obj = new JSONObject();
        obj.put("type", "getId");
        obj.put("sessionId", session.getId());
        session.sendMessage(new TextMessage(obj.toJSONString()));
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        //소켓 종료
        log.trace("소켓 죽었다");
        if(rls.size() > 0) { //소켓이 종료되면 해당 세션값들을 찾아서 지운다.
            for(int i=0; i<rls.size(); i++) {
                rls.get(i).remove(session.getId());
            }
        }
        super.afterConnectionClosed(session, status);
    }

    private static JSONObject jsonToObjectParser(String jsonStr) {
        JSONParser parser = new JSONParser();
        JSONObject obj = null;
        try {
            obj = (JSONObject) parser.parse(jsonStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return obj;
    }

}
