<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="kdtweb.beans.User, java.util.*, java.sql.*" %>
<%@ include file="include/header.jsp" %>
<jsp:useBean id="memlist" class="kdtweb.dao.members.SelectMem" scope="page" />
<%
  List<User> userList = null;
  try{
      userList = memlist.selectMem();
  }catch(SQLException e){
	   out.println("에러가 발생했습니다. "+ e.getMessage());        	   
  }
%>
<script src="js/photo-gallery.js"></script>

    <div class="row">
           <div class="col-12">
               <div class="bg-white rg p-5">
                   <h1 class="text-center py-5">회원 관리</h1>
                   <p class="text-danger text-center pb-5">관리자 모드 입니다.</p>
                   <table class="table table-bordered memtable">
                      <thead>
                         <tr>
                            <th>No</th>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>전화번호</th>
                            <th>주소</th>
                            <th>가입일</th>
                            <th>level</th>
                         </tr>
                      </thead>  
                      <tbody>
       <%
           if(userList != null && !userList.isEmpty()){
           for(User user : userList){   
           int level = user.getGrade();
           String lv1 = "", lv2 = "", lv3 = "", lv4="";
           switch(level){
              case 0:
        	     lv4 = "selected";
        	   break;
               case 1:
        	      lv1 = "selected";
        	   break;
               case 2:
        	      lv2 = "selected";
        	   break;
               case 3:
        	      lv3 = "selected";
        	   break;       	   
           }
       %>       
       
          <tr>
             <td><%=user.getId() %></td>  
             <td><%=user.getUserid() %></td>  
             <td><%=user.getUsername() %></td>  
             <td><%=user.getUseremail() %></td>  
             <td><%=user.getUsertel() %></td>  
             <td data-bs-toggle="tooltip" 
                 data-bs-placement="top" 
                 title="(<%=user.getUserpost() %>) 
                        <%=user.getUseraddr1() %>
                        <%=user.getUseraddr2() %>
                        <%=user.getUseraddrexc() %>"><%=user.getUseraddr1() %>
             </td>  
             <td><%=user.getRdate() %></td>  
             <td>
                 <select class="edtlevel" data-id="<%=user.getId()%>">
                    <option value="1" <%=lv1 %>>일반회원</option>
                    <option value="2" <%=lv2 %>>특별회원</option>
                    <option value="3" <%=lv3 %>>운영진</option>
                    <option value="0" <%=lv4 %>>회원보류</option>
                    <option value="99">회원강탈</option>
                 </select>                   
          </tr>      
       <%
           } 
           }
       %>               </tbody>                       
                   </table>
               </div>
           </div>    
     </div>
   <%@ include file="include/footer.jsp" %>
   <script>
      var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
      var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
         return new bootstrap.Tooltip(tooltipTriggerEl)
      });
      
      $(function(){

          $(document).on("change", ".edtlevel", function(){		  
    		 const lv = $(this).val();
    		 const id = $(this).data("id");
    		 let ok = false;
    		 if(lv == 99) {
    		   ok = confirm("회원을 강제로 탈퇴시키려 합니다. 진행하시겠습니까?"); 	 
    		 }else{
               ok = true;    			 
    		 }
    		 
    		 if(ok){
	    		 $.ajax({
	    			 url: "adminedt",
	    			 type: "post",
	    			 data: {
	    				 lv: lv,
	    				 id: id
	    			 },
	    			 success: function(data){
	    				 if(data == 1){
	    					if(id == 99) {
	    					    alert("삭제되었습니다.");
	    					}else{
	    						alert("수정되었습니다.")
	    					}
	    					location.reload(); //새로 고침
	    				 }
	    			 },
	    			 error: function(xhr, status, error){
	    				 alert("Error : " + xhr.responseText);
	    			 }
	    		 });
    		 }
    	  });
      });
</script>
</body>
</html>
  