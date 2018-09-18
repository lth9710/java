package com.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileManager {

	
	//���ϴٿ�ε� �޼ҵ�
	//saveFileName : ������ ����� ���ϸ�
	//originalFileName : Ŭ���̾�Ʈ�� ���ε��� ����
	//path : ������ ����� ���� ���
	
	public static boolean doFileDownload(HttpServletResponse response,
			String saveFileName,String originalFileName,String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			if(originalFileName==null||originalFileName.equals("")){
				originalFileName = saveFileName;
			}

			//������ �ٿ�޾Ƽ� Ŭ���̾�Ʈ�� �����̸��� �����Ҷ�
			//�ѱ� �̸� ���� ����
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
	
	
	//���ϻ���
	public static void doFileDelete(String saveFileName,String path){
		
		try {
			
			String filePath = path + File.separator + saveFileName;
			
			File f = new File(filePath);
			
			if(f.exists()){
				f.delete(); //������ ���� ����
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
				saveFileName = "����";
			}

			//������ �ٿ�޾Ƽ� Ŭ���̾�Ʈ�� �����̸��� �����Ҷ�
			//�ѱ� �̸� ���� ����
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
