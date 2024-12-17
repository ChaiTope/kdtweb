<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"
   import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto, java.sql.*, java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Board bbs = new Board();
ArrayList<BoardDto> boardList = null;
//try {
//   boardList = bbs.listBoard();
//} catch (SQLException e) {
//   e.printStackTrace();
//}
int pageGroup = 5; // n개의 페이지 그룹 생성 현재 페이지 수 5개로 설정
int listView = 10; // 한개의 페이지에 보여질 목록의 수 현재 한 페이지에 10개의 글이 보임
int totalPosts = boardList.size(); // 게시글의 총 갯수(boardList의 배열의 크기)
int totalPages = (int) Math.ceil((double) totalPosts / listView); // 페이지의 총 갯수


//현재 페이지 처리 (쿼리 파라미터로 받기)
int currentPage = 1; // 사용자가 보고 있는 현재 페이지, 기본값은 1

//사용자가 페이지 번호를 클릭했을 때, 그 번호는 URL 파라미터로 전달 
//예를 들어, 사용자가 2페이지를 클릭했다면 URL이 ?currentPage=2와 같이 설정
String pageParam = request.getParameter("currentPage");
//URL에 페이지 번호가 포함되어 있는지 확인하는 조건문
if (pageParam != null && !pageParam.isEmpty()) {
	//페이지 번호가 포함되어 있으면 pageParam을 정수로 변환하여 currentPage 변수에 저장
	//pageParam은 문자열 형태로 전달되기 때문에, Integer.parseInt로 정수형으로 변환
 currentPage = Integer.parseInt(pageParam);
}

//현재 페이지 그룹의 시작 페이지 번호 계산
int groupStartPage = ((currentPage - 1) / pageGroup) * pageGroup + 1;
//현재 페이지 그룹의 마지막 페이지 번호 계산
int groupEndPage = Math.min(groupStartPage + pageGroup - 1, totalPages);

//게시글 자르기 (startPageIndex ~ endPageIndex까지 잘라서 보여줌)
int startPageIndex = (currentPage - 1) * listView;  // 건너뛸 데이터 수
int endPageIndex = Math.min(startPageIndex + listView, totalPosts);  // 끝 인덱스 계산

//아래는 버튼을 누를때 마다 작동

//전체 게시글 목록(boardList)에서 현재 페이지에 맞는 게시글들만 잘라서 가져오는 부분
//startPageIndex와 endPageIndex는 사용자가 보고 있는 현재 페이지에서 몇 번째 게시글부터 몇 번째까지 보여줄지를 결정
//subList는 전체 목록 중에서 필요한 범위만 자르기 위한 메서드 
//예를 들어, 사용자가 2페이지를 보고 있다면 11번 게시글부터 20번 게시글까지만 가져와서 보여줌
List<BoardDto> pageView = boardList.subList(startPageIndex, endPageIndex);

//자른 데이터(pageView)를 JSP로 전달, JSP에서 c:forEach를 사용해 이 데이터를 반복해서 출력할 수 있게 만듬
request.setAttribute("pageView", pageView);

//현재 사용자가 보고 있는 페이지 번호를 JSP에 전달, 이 값은 JSP에서 페이지 번호를 표시하거나, "이전", "다음" 버튼을 활성화할 때 사용
request.setAttribute("currentPage", currentPage);

//전체 페이지 수를 JSP에 전달합니다. 이 값은 페이지 번호를 출력하거나, 페이지 번호 버튼을 몇 개까지 보여줄지를 결정하는 데 사용
request.setAttribute("totalPages", totalPages);

//현재 페이지 그룹의 시작 페이지 번호를 JSP에 전달,예를 들어, pageGroup이 5일 경우,
//6번 페이지에 있으면 페이지 그룹은 6~10이므로 groupStartPage는 6이된다.
request.setAttribute("groupStartPage", groupStartPage);

//현재 페이지 그룹의 마지막 페이지 번호를 JSP에 전달, 페이지네이션 버튼에서 어디까지 페이지 번호를 보여줄지를 결정하는 데 사용
//예를 들어, 페이지 그룹이 6~10일 때 groupEndPage는 10이 된다.
request.setAttribute("groupEndPage", groupEndPage);

//한 페이지에 보여줄 게시글의 수를 JSP에 전달, JSP에서 페이지 크기를 변경하거나 다른 곳에서 사용할 수 있도록 listView 값을 전달
request.setAttribute("listView", listView);
%>
<h1 class="text-center mb-5">게시판</h1>
<table class="bbslist table-hover">
   <colgroup>
      <col width="10%">
      <col width="50%">
      <col width="15%">
      <col width="15%">
      <col width="10%">
   </colgroup>
   <thead>
      <tr>
         <th>번호</th>
         <th>제목</th>
         <th>작성자</th>
         <th>날짜</th>
         <th>조회수</th>
      </tr>
   </thead>
   <tbody>
      <c:forEach var="post" items="${pageView}">
         <tr>
            <td>${post.num}</td>
            <td class="ellipsis"><a href="bbs.jsp?bbs=view&num=${post.num}">${post.title}</a></td>
            <td class="ellipsis">${post.writer}</td>
            <td>${post.viewDate}</td>
            <td>${post.count}</td>
         </tr>
      </c:forEach>
   </tbody>
</table>

<div class="text-right my-5 px-5">
   <a href="?mode=write" class="btn btn-success">글쓰기</a>
</div>

<!-- 페이지네이션 -->
<div class="d-flex justify-content-center">
<ul class="pagination">
    <!-- Previous 버튼 -->
    	<!-- groupStartPage 값에 따라 버튼을 활성화할지 비활성화할지를 결정. -->
        <!-- groupStartPage > 1 조건은 현재 페이지 그룹이 첫 번째 그룹인지 아닌지를 확인, 1일 경우 Previous버튼이 비활성화 -->
        <!-- groupStartPage > 1일 때, 아무것도 하지 않고(''), 그렇지 않으면 disabled 클래스를 추가하여 버튼을 비활성화 -->
        <li class="page-item ${groupStartPage > 1 ? '':'disabled'}">
        
        	<!-- 현재 페이지 그룹에서 이전 그룹으로 이동할 수 있게 링크를 설정 -->
        	<!-- currentPage=${groupStartPage - 1}: 현재 페이지 그룹의 첫 번째 페이지 번호에서 1을 뺀 값으로 설정하여,
        	 이전 페이지 그룹으로 이동 -->
			<!-- size=${listView}: 한 페이지에 보여줄 게시글 수를 유지한 채, 페이지 이동을 처리 -->
            <a class="page-link" href="?currentPage=${groupStartPage - 1}&size=${listView}">Previous</a>
        </li>
        
    <!-- 페이지 번호를 동적으로 출력하기 위한 반복문 -->
    <!-- var:페이지 번호를 담는 변수, begin~반복문의 시작값(페이지그룹의 첫 페이지의 번째 번호) 
    end~반복문의 끝값(현재페이지의 마지막페이지 번호), 이 forEach는 6~10번 페이지 그룹이라면, 6, 7, 8, 9, 10을 출력-->
    <c:forEach var="i" begin="${groupStartPage}" end="${groupEndPage}">
    	<!-- 페이지 번호를 리스트 항목(<li>)으로 출력하며, 현재 보고 있는 페이지는 시각적으로 활성화 -->
    	<!-- c:if~는 현재 페이지 번호(i)가 현재 사용자가 보고 있는 페이지(currentPage)와 같으면 active 클래스를 추가 -->
    	<!-- active 클래스는 현재 페이지를 시각적으로 구분하기 위해 사용-->
        <li class="page-item <c:if test='${i == currentPage}'>active</c:if>">
        	<!--  각 페이지 번호에 클릭할 수 있는 링크를 추가 -->
        	<!-- currentPage=${i}: 사용자가 클릭한 페이지 번호를 URL 파라미터로 전달합니다. 예를 들어, i가 7이면 ?currentPage=7 -->
            <a class="page-link" href="?currentPage=${i}&size=${listView}">${i}</a>
        </li>
    </c:forEach>
    
    <!-- Next 버튼, 마지막 페이지 그룹이 아닐 때만 다음 페이지 그룹으로 이동할 수 있게 설정 -->
    	<!-- 만약 마지막 페이지 그룹이라면, 버튼을 비활성화(disabled) 상태로 표시 -->
        <li class="page-item ${groupEndPage < totalPages ? '':'disabled'}">
        	<!-- 현재 페이지 그룹에서 다음 그룹으로 이동할 수 있게 링크를 설정 -->
        	<!-- currentPage=${groupStartPage + 1}: 현재 페이지 그룹의 첫 번째 페이지 번호에서 1을 더한 값으로 설정하여,
        	 다음 페이지 그룹으로 이동 -->
			<!-- size=${listView}: 한 페이지에 보여줄 게시글 수를 유지한 채, 페이지 이동을 처리 -->
            <a class="page-link" href="?currentPage=${groupEndPage + 1}&size=${listView}">Next</a>
        </li>
</ul>
</div>
<script>
</script>