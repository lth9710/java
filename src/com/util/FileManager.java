package com.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {

	
	//파일다운로드 메소드
	//saveFileName : 서버에 저장된 파일명
	//originalFileName : 클라이언트가 업로드한 파일
	//path : 서버에 저장된 실제 경로
	
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName,String originalFileName,String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			if(originalFileName==null||originalFileName.equals("")){
				originalFileName = saveFileName;
			}

			//파일을 다운받아서 클라이언트에 파일이름을 생성할때
			//한글 이름 깨짐 방지
			originalFileName = new String(
					originalFileName.getBytes("euc-kr"),"ISO-8859-1"); 
			
			File f = new File(filePath);
			
			if(!f.exists()){
				return false;
			}
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment;fileName=" + originalFileName);
			
			BufferedInputStream bis = new BufferedInputStream(
					new FileInputStream(f));
			
			OutputStream out = response.getOutputStream();
			
			int n;
			byte bytes[] = new byte[4096];
			while((n=bis.read(bytes,0,4096))!=-1){
				
				out.write(bytes,0,n);
			}

			out.flush();
			out.close();
			bis.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}return true;
	}
	
	
	//파일삭제
	public static void doFileDelete(String saveFileName,String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			File f = new File(filePath);
			
			if(f.exists()){
				f.delete(); //물리적 파일 삭제
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}
	
	
	
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName,String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			if(saveFileName==null||saveFileName.equals("")){
				saveFileName = "오류";
			}

			//파일을 다운받아서 클라이언트에 파일이름을 생성할때
			//한글 이름 깨짐 방지
			saveFileName = new String(
					saveFileName.getBytes("euc-kr"),"ISO-8859-1"); 
			
			File f = new File(filePath);
			
			if(!f.exists()){
				return false;
			}
			
			response.setContentType("application/octet-stream");
			response.setHeader("Content-disposition", "attachment;fileName=" + saveFileName);
			
			BufferedInputStream bis = new BufferedInputStream(
					new FileInputStream(f));
			
			OutputStream out = response.getOutputStream();
			
			int n;
			byte bytes[] = new byte[4096];
			while((n=bis.read(bytes,0,4096))!=-1){
				
				out.write(bytes,0,n);
			}

			out.flush();
			out.close();
			bis.close();
			
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}return true;
	}
	
}
