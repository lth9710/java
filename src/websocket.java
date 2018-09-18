
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
	 * �� ������ ����Ǹ� ȣ��Ǵ� �̺�Ʈ
	 */
	@OnOpen
	public void handleOpen(){
		System.out.println("client is now connected...");
	}
	/**
	 * �� �������κ��� �޽����� ���� ȣ��Ǵ� �̺�Ʈ
	 * @param message
	 * @return
	 */
	
	@OnMessage
	public String handleMessage(String message,Session userSession) throws IOException{
		String senderId = (String)userSession.getUserProperties().get("senderId");
		System.out.println("receive from client : "+message);
		//�޼������޾�����
		 /*userSession.getUserProperties().put("senderId", senderId); //�߰��Ѱ� 1
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
	 * �� ������ ������ ȣ��Ǵ� �̺�Ʈ
	 */
	@OnClose
	public void handleClose(Session userSession){
		System.out.println("client is now disconnected...");
		sessionUsers.remove(userSession);

	}
	/**
	 * �� ������ ������ ���� ȣ��Ǵ� �̺�Ʈ
	 * @param t
	 */
	@OnError
	public void handleError(Throwable t){
		t.printStackTrace();
	}


	


}



