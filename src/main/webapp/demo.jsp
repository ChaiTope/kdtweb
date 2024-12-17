<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%
  String user = "민수";
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <c:set var="name" value="james" />
  <c:set var="user" value="<%=user %>" />
  이름 : ${name }
  
  유저 : <%=user %>
  
  유저 : ${user }
</body>
</html>