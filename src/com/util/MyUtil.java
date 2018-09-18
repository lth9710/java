package com.util;

public class MyUtil {//페이징처리

	//전체페이지수
	public int getPageCount(int numPerPage,int dataCount){
		int pageCount=0;
		pageCount = dataCount / numPerPage;

		if(dataCount % numPerPage !=0) // 나머지가 존재한다면 페이지를 하나 늘려서 나머지 데이터를 마지막 페이지에 넣는다.
			pageCount++;

		return pageCount;
	}
	//페이징처리 메소드
	//currentPage : 현재 표시할 페이지
	//totalPage : 전체 페이지수
	//listUrl : 링크를 설정할 URL 
	public String pageIndexList(int currentPage,int totalPage,String listUrl){

		int numPerBlock = 3;

		int currentPageSetup; //표시할 첫페이지-1 

		int page; //반복문 i와 똑같은 역할

		StringBuffer sb = new StringBuffer(); // String을 쓰면 쓰래기값이 생기므로 StringBuffer를 사용한다.

		if(currentPage==0||totalPage==0) //데이터가 없다면
			return "";

		//list.jsp? 만 들어가있는 상태임.
		//list.jsp?searchKey=subject&searchValue='수지'
		//아직은 구현안된 기능.
		if(listUrl.indexOf("?")!=-1){
			listUrl = listUrl + "&"; //물음표가 있다면
		}else{
			listUrl = listUrl + "?"; //물음표가 없다면 물음표를 붙여라
		}
		
		// < 11 12 13 14 15 > 인 상황에서 14인 경우
		// 이전을 눌르면 10이 나와야 한다.
		//표시할 페이지에 -1한값
		currentPageSetup = (currentPage/numPerBlock)*numPerBlock;

		if(currentPage % numPerBlock==0)
			currentPageSetup = currentPageSetup-numPerBlock;

		
		//◀이전
		if(totalPage > numPerBlock && currentPageSetup>0){
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					currentPageSetup +"\">◀이전</a>&nbsp;");
			//<a href="list.jsp?pageNum=5">◀이전</a>&nbsp;
		}

		//바로가기페이지
		// < 1 2 3 4 5 > 에서 화살표가 아닌 숫자 출력 위해
		page = currentPageSetup +1;

		while(page<=totalPage &&
				page <=(currentPageSetup+numPerBlock)){
						// ◀			//5 6 7 8 9 10

			if(page==currentPage){ //지금 보는 페이지가 원하는 페이지었다면 링크 비활성화
				sb.append("<font color=\"Fuchsia\">"+
						page + "</font>&nbsp;");
				//<font color="Fuchsia">9</font>&nbsp;
			}else{ // 안보는 페이지들은 링크
				sb.append("<a href=\"" + listUrl + "pageNum=" +
						page + "\">" + page + "</a>&nbsp;");
				//<a href="list.jsp?pageNum=10">10</a>&nbsp;
			}
			page++;
		}

		//다음▶
		if(totalPage-currentPageSetup > numPerBlock){ //조건이 맞다면 나타나게함.
			sb.append("<a href=\"" + listUrl + "pageNum=" +
					page + "\">다음▶</a>&nbsp;");
			//<a href="list.jsp?pageNum=11">다음▶</a>&nbsp;
		}
		return sb.toString();
	}
}



