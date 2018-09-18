
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.fiveTing.ChatDAO;
import com.fiveTing.ChatDTO;
import com.util.DBCPConn;





@ServerEndpoint("/websocket")
public class websocket{

	static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	
	
	
	/***
	 * 웹 소켓이 연결되면 호출되는 이벤트
	 */
	@OnOpen
	public void handleOpen(){
		System.out.println("client is now connected...");
	}
	/**
	 * 웹 소켓으로부터 메시지가 오면 호출되는 이벤트
	 * @param message
	 * @return
	 */
	
	@OnMessage
	public String handleMessage(String message,Session userSession) throws IOException{
		String senderId = (String)userSession.getUserProperties().get("senderId");
		System.out.println("receive from client : "+message);
		//메세지를받았을때
		 /*userSession.getUserProperties().put("senderId", senderId); //추가한것 1
*/		if(senderId == null){
            userSession.getUserProperties().put("senderId", message);
		}else{
		Connection conn = DBCPConn.getConnection();
		ChatDTO dto = new ChatDTO();
		ChatDAO dao = new ChatDAO(conn);
		dto.setId(senderId);//
		dto.setContent(message);
		dao.insertData(dto);
		}
		String replymessage = "echo "+message;
		System.out.println("send to client : "+replymessage);

		DBCPConn.close();
		return replymessage;
			
	}
	
	
	
	/**
	 * 웹 소켓이 닫히면 호출되는 이벤트
	 */
	@OnClose
	public void handleClose(Session userSession){
		System.out.println("client is now disconnected...");
		sessionUsers.remove(userSession);

	}
	/**
	 * 웹 소켓이 에러가 나면 호출되는 이벤트
	 * @param t
	 */
	@OnError
	public void handleError(Throwable t){
		t.printStackTrace();
	}


	


}



