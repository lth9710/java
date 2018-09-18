package com.util;

public class MyUtil {//����¡ó��

	//��ü��������
	public int getPageCount(int numPerPage,int dataCount){
		int pageCount=0;
		pageCount = dataCount / numPerPage;

		if(dataCount % numPerPage !=0) // �������� �����Ѵٸ� �������� �ϳ� �÷��� ������ �����͸� ������ �������� �ִ´�.
			pageCount++;

		return pageCount;
	}
	//����¡ó�� �޼ҵ�
	//currentPage : ���� ǥ���� ������
	//totalPage : ��ü ��������
	//listUrl : ��ũ�� ������ URL 
	public String pageIndexList(int currentPage,int totalPage,String listUrl){

		int numPerBlock = 3;

		int currentPageSetup; //ǥ���� ù������-1 

		int page; //�ݺ��� i�� �Ȱ��� ����

		StringBuffer sb = new StringBuffer(); // String�� ���� �����Ⱚ�� ����Ƿ� StringBuffer�� ����Ѵ�.

		if(currentPage==0||totalPage==0) //�����Ͱ� ���ٸ�
			return "";

		//list.jsp? �� ���ִ� ������.
		//list.jsp?searchKey=subject&searchValue='����'
		//������ �����ȵ� ���.
		if(listUrl.indexOf("?")!=-1){
			listUrl = listUrl + "&"; //����ǥ�� �ִٸ�
		}else{
			listUrl = listUrl + "?"; //����ǥ�� ���ٸ� ����ǥ�� �ٿ���
		}
		
		// < 11 12 13 14 15 > �� ��Ȳ���� 14�� ���
		// ������ ������ 10�� ���;� �Ѵ�.
		//ǥ���� �������� -1�Ѱ�
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;

		if(currentPage % numPerBlock==0)
			currentPageSetup = currentPageSetup-numPerBlock;

		
		//������
		if(totalPage > numPerBlock && currentPageSetup>0){
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					currentPageSetup +"\">������</a>&nbsp;");
			//<a href="list.jsp?pageNum=5">������</a>&nbsp;
		}

		//�ٷΰ���������
		// < 1 2 3 4 5 > ���� ȭ��ǥ�� �ƴ� ���� ��� ����
		page = currentPageSetup +1;

		while(page<=totalPage &&
				page <=(currentPageSetup+numPerBlock)){
						// ��			//5 6 7 8 9 10

			if(page==currentPage){ //���� ���� �������� ���ϴ� ���������ٸ� ��ũ ��Ȱ��ȭ
				sb.append("<font color=\"Fuchsia\">"+
						page + "</font>&nbsp;");
				//<font color="Fuchsia">9</font>&nbsp;
			}else{ // �Ⱥ��� ���������� ��ũ
				sb.append("<a href=\"" + listUrl + "pageNum=" +
						page + "\">" + page + "</a>&nbsp;");
				//<a href="list.jsp?pageNum=10">10</a>&nbsp;
			}
			page++;
		}

		//������
		if(totalPage-currentPageSetup > numPerBlock){ //������ �´ٸ� ��Ÿ������.
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					page + "\">������</a>&nbsp;");
			//<a href="list.jsp?pageNum=11">������</a>&nbsp;
		}
		return sb.toString();
	}
}



