<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kdtweb.util.Paging" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%
  //Paging(int totalRecords, int recordsPerPage, int currentPage, int pagesPerGroup)
  int totalRecords = 2498;
  int recordsPerPage = 16;
  int pagesPerGroup = 13;
  int currentPage = 1;
  
  if(request.getParameter("pg") != null) {
	  currentPage = Integer.parseInt(request.getParameter("pg"));
  }
  
  int limit = (currentPage - 1) * recordsPerPage;
  
  Paging paging = new Paging(totalRecords, recordsPerPage, currentPage, pagesPerGroup);
  request.setAttribute("paging", paging);
  request.setAttribute("limit", limit);
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
<div class="container">
<h1 class="my-5 py-5 text-center">
  select * from bbs_bbs order by num desc limit ${limit}, 16;
</h1>
	<ul class="pagination">
	<!-- 이전그룹 -->
	<c:if test="${paging.startPageOfGroup > 1 }">
	  <li class="page-item"><a class="page-link" href="?pg=${paging.startPageOfGroup - 1 }">Previous</a></li>
	</c:if>  
	
	<c:forEach var="i" begin="${paging.startPageOfGroup }" end="${paging.endPageOfGroup}">
	   <li class='page-item <c:if test="${ i == paging.currentPage}">active</c:if>'><a class="page-link" href="?pg=${i}">${i }</a></li>
	</c:forEach>  
	  
	  
	 <!-- 다음그룹 -->
	<c:if test="${paging.endPageOfGroup < paging.totalPages }">  
	  <li class="page-item"><a class="page-link" href="?pg=${paging.endPageOfGroup + 1}">Next</a></li>
	</c:if>  
	</ul>
</div>
</body>
</html>