<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    import="kdtweb.dao.bbs.Works, 
            kdtweb.beans.WorksDto, 
            java.sql.*, 
            java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%
	Works bbs = new Works();
	List<WorksDto> boardList = null;
	try{
		boardList = bbs.lBoard();
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("boardList", boardList);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자모드</title>
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/fonts.css">
    <link rel="stylesheet" href="css/remixicon.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/pycs-layout.jquery.js"></script>
    <script src="js/jquery.validate.min.js"></script>
    <script src="js/script.js"></script>
</head>
<body>
	<div class="container position-relative pl-300">
		<table class="table-hover table">
			<thead>
				<th>번호</th>
				<th>제목</th>
			</thead>
			<tbody>
			<c:forEach var="list" items="${boardList }"	>
				<tr>
					<td>
					${list.id }
					</td>
					<td style="padding-left: ${list.depth*15}px;">
					<c:if test="${list.depth > 0 }">-></c:if>
					${list.title }
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>