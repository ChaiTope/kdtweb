<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="include/header.jsp" %>
<div class="row">
  <div class="col-12">
     <div class="bg-white rg findidpass">
       <h1 class="text-center py-5">아이디 찾기</h1>
       <p class="text-center mb-5">아이디를 찾으시려면 이메일 주소를 입력하세요.</p>
       <form name="findidform" id="findidform" action="findidok.jsp" method="post">
          <ul class="registerul">
             <li class="d-flex py-4">
                <label for="userid" class="col-2 text-right">이메일주소</label>
                <div class="col-4">
                   <input type="text" name="useremail" id="usremail" placeholder="이메일" class="form-control">
                </div>
             </li>
             <li class="text-center pt-1 pb-5">
                   <button type="reset" class="btn btn-warning py-2 px-5 mx-2">취소</button>
                   <button type="submit" class="btn btn-success py-2 px-5 mx-2">전송</button>
             </li>    
          </ul>
       </form>
       
       <h1 class="text-center py-5">비밀번호 찾기</h1>
       <p class="text-center mb-5">비밀번호를 찾으시려면 아이디와 이메일 주소를 입력하세요.</p>
       <form name="findpwdform" id="findpwdform" action="findpwdok.jsp" method="post">
          <ul class="registerul">
             <li class="d-flex py-4">
                <label for="userid" class="col-2 text-right">아이디</label>
                <div class="col-4">
                   <input type="text" name="userid" id="usrid" placeholder="아이디" class="form-control">
                </div>
             </li>
             <li class="d-flex py-4">
                <label for="userid" class="col-2 text-right">이메일주소</label>
                <div class="col-4">
                   <input type="text" name="useremail" id="usremail" placeholder="이메일" class="form-control">
                </div>
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
<%@ include file="include/footer.jsp" %>
