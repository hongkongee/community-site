//package project.blog.community.util;
//
//import jakarta.servlet.http.HttpSession;
//import project.blog.community.project.dto.response.LoginUserResponseDTO;
//import project.blog.community.project.dto.response.MarketLoginUserResponseDTO;
//
//public class MarketUtils {
//
//    public static final String LOGIN_kEY = "login";
//
//    public static String getCurrentLoginMemberAccount(HttpSession session){
//        MarketLoginUserResponseDTO loginUser = (MarketLoginUserResponseDTO) session.getAttribute(LOGIN_kEY);
//        return loginUser.getAccount();
//    }
//
//}
