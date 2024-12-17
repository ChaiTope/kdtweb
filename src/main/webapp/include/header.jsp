<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
 
<!DOCTYPE html>
<html lang="ko">
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
       <header class="position-absolute">
          <div class="logo"><a href="index.jsp"><img src="images/logo.png" alt="kdt community"></a></div>
         
      <c:choose>
         <c:when test="${sessionScope.userid == null}">
	          <form id="loginform" name="loginform" class="login" method="post" action="loginok">
	             <input type="text" class="form-control" name="userid" id="userid" placeholder="아이디">
	             <input type="password" class="form-control" name="userpass" id="userpass" placeholder="비밀번호">
	             <div class="text-right"><label><input type="checkbox" name="rid" id="rid" value="ok" /> 아이디 저장</label></label></div>
	             <button type="submit" class="btn btn-success btn-block">로 그 인</button>
	          </form>
	          <div class="d-flex justify-content-between px-2 mb-5">
	            <a href="findidpass.jsp">아이디/비밀번호 찾기</a>
	            <a href="register.jsp">회원가입</a>
	          </div>
        </c:when>
        <c:when test="${sessionScope.userid =='admin'}">  
             <div id="loginform" class="login">
             <h5 class="text-center">
                관리자님 로그인
             </h5>
             <ul class="list-group">
                <li class="list-group-item">
                    <a href="mem-list.jsp">회원관리</a>
                </li>
                <li class="list-group-item">
                    <a href="logout.jsp">로그아웃</a>
                </li>
             </ul>   
          </div>          
       </c:when>     		   
       <c:otherwise>
          <div id="loginform" class="login">
             <h5 class="text-center">
                 ${sessionScope.userid }님 로그인
              
             </h5>
             <p class="text-center">
              <a href="editmem.jsp">회원정보수정</a> | <a href="logout.jsp">로그아웃</a>
             </p>
             <p class="text-center">
              <a href="bbs.jsp?bbs=list">게시판 이동</a> | <a href="bbs.jsp?bbs=write">글쓰기</a>
             </p>
          </div>
       </c:otherwise>
     </c:choose>
     
          <div>이미지배너</div>
       </header>