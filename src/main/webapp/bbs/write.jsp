<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
    
<link rel="stylesheet" href="css/summernote-bs4.css">
<script src="js/summernote-bs4.min.js"></script>
<script src="js/lang/summernote-ko-KR.js"></script>
<div class="bg-white bbs">

<h1 class="text-center my-5">글쓰기</h1>
<form name="write_form" id="write_form" class="row was-valited" method="post">
   <div class="col-md-6 my-3">
      <div class="row align-items-center">
         <label for="writer" class="w-label">이름</label>
         <input type="text" class="form-control" name="writer" id="writer" required />
      </div>
   </div>
   
<c:choose>
   <c:when test="${sessionScope.userid == null }">
   <div class="col-md-6 my-3">
      <div class="row align-items-center">
         <label for="password" class="w-label">비밀번호</label>
         <input type="password" class="form-control" name="password" id="password" required />
      </div>
   </div>
   </c:when>
       
   <c:otherwise>
   <div class="col-md-6 my-3"></div>
   </c:otherwise>
</c:choose>
       
   <div class="col-md-12 my-3">
      <div class="row align-items-center">
         <label for="title" class="w-label">제목</label>
         <input type="text" class="form-control" name="title" id="title" required />
      </div>
   </div>
    <div class="col-md-12 my-3">
      <div class="row align-items-center">
         <label for="password" class="w-label">내용</label>
         <textarea class="form-control" name="contents" id="contents" required></textarea>
      </div>
    </div>
    <div class="col-md-12 text-center">
       <a href="javascript:history.back()" class="btn btn-danger mx-2 px-4">취소</a>
       <button class="btn btn-success write mx-2 px-4">작성완료</button>
    </div>  
</form>

</div>
<script>
$(function(){
   $('#contents').summernote({
	 height: 250  
   });	
   
   $(".write").click(function(e){
	  e.preventDefault();
	  
	  // 유효성 검사
	  if ($("#writer").val().trim() === "") {
		alert("이름을 입력해주세요.");
		$("#writer").focus();
		return;
	  }

	  if ($("#title").val().trim() === "") {
		alert("제목을 입력해주세요.");
		$("#title").focus();
		return;
	  }

	  if ($("#contents").val().trim() === "") {
		alert("내용을 입력해주세요.");
		$("#contents").focus();
		return;
	  }

	  // 세션이 없으면 비밀번호도 체크
	  <% if (session.getAttribute("userid") == null) { %>
	  if ($("#password").val().trim() === "") {
		alert("비밀번호를 입력해주세요.");
		$("#password").focus();
		return;
	  }
	  <% } %>
	  
	  //폼데이터 직렬화
	  const formData = $("#write_form").serialize();
	  //ajax 요청
	  $.ajax({
		url: "bbswriteok",
		type: "post",
		data: formData,
		success: function(data){
			console.log(data);
			if(data.result == 1){
				alert("글 작성 완료!");
				window.location.href="bbs.jsp?bbs=list";
			}else{
				alert("문제가 발생했어요. 관리자에게 문의 하세요.");
			}
		},
		error: function(xhr, status, error){
			alert("문제가 발생했어요." + error);
		}
	  });
   });
});
</script>