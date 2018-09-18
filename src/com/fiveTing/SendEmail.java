package com.fiveTing;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
	
	private String receiverEmail;
	private String senderEmail;
	private String senderName;
	private String subject;
	private String content;

	private String mailHost; // 메일 서버
	private String mailType; // 메일 유형

	public SendEmail() {
		this.mailHost = "localhost";
		this.mailType = "text/html;charset=UTF-8";
	}

	public SendEmail(String mailHost) {
		this.mailHost = "mailHost";
		this.mailType = "text/html;charset=UTF-8";
	}

	public String getReceiverEmail() {
		return receiverEmail;
	}

	public void setReceiverEmail(String receiverEmail) {
		this.receiverEmail = receiverEmail;
	}

	public String getSenderEmail() {
		return senderEmail;
	}

	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getMailHost() {
		return mailHost;
	}

	public void setMailHost(String mailHost) {
		this.mailHost = mailHost;
	}

	public String getMailType() {
		return mailType;
	}

	public void setMailType(String mailType) {
		this.mailType = mailType;
	}

	public boolean sendMail() {

		try {
			Properties props = System.getProperties();
			props.put("mail.stmp.host", mailType);

			Session session = Session.getDefaultInstance(props, null);

			// 메일을 보낸 메세지 클래스
			Message msg = new MimeMessage(session);

			// 보내는 사람
			if (senderName == null || senderName.equals("")) {
				msg.setFrom(new InternetAddress(senderEmail));
			} else {
				msg.setFrom(new InternetAddress(senderEmail, senderName,
						"UTF-8"));
			}

			// 받는 사람
			msg.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse(receiverEmail));

			// 제목
			msg.setSubject(subject);

			// html형식인 경우 \r\n을 <br/>로 변경
			if (mailType.indexOf("text/html") != -1) {
				content = content.replaceAll("\r\n", "<br/>");
			}

			msg.setHeader("X-Mailer", senderName);

			// 메일 보낸 날짜
			msg.setSentDate(new Date());

			// 메일 전송
			Transport.send(msg);


		} catch (MessagingException e) {
			System.out.println(e.toString());

		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return true;
	}

}
