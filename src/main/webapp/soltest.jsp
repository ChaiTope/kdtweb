<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="row">
  <div class="col-12">
     <div class="bg-white rg">
       <h1 class="text-center py-5">회원 정보 기입</h1>
       <form name="testform" id="testform" action="testok" method="post">
          <ul class="registerul">
             <li class="d-flex py-4">
                <label for="userid" class="col-2 text-right">아이디</label>
                <div class="col-4">
                   <input type="text" name="testid" id="testid"" placeholder="아이디" class="form-control">
                </div>
             </li>
             <li class="d-flex py-4">
                <label for="userpass" class="col-2 text-right">비밀번호</label>
                <div class="col-4">
                   <input type="password" name="testpass" id="testpass" placeholder="비밀번호" class="form-control">
                </div>
             </li>
             <li class="d-flex py-4">
                <label for="" class="col-2 text-right">전화번호</label>
                <div class="col-2">
                   <input type="text" id="tel1" class="form-control">
                </div>
                -
                <div class="col-2">
                   <input type="text" id="tel2" class="form-control">
                </div>
                -
                <div class="col-2">
                   <input type="text" id="tel3" class="form-control">
                </div>
                <input type="hidden" name="tel" id="tel" />
             </li>   
             <li class="text-center pt-1 pb-5">
                   <button type="reset" class="btn btn-warning py-2 px-5 mx-2">취소</button>
                   <button type="submit" class="btn btn-success py-2 px-5 mx-2">전송</button>
             </li>      
          </ul>
       </form>
      </div>
     </div>
  </div>
</body>
</html>
<%@ include file="include/footer.jsp" %>
