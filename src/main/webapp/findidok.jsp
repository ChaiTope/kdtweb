<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"   
%>
<%@ include file="include/header.jsp" %>
<jsp:useBean id="connBean" class="kdtweb.dao.MySqlConnect" scope="page" />
<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet res = null;

   String email = request.getParameter("useremail");
   
   if( email !=null && !email.isEmpty()){  
	   try{
		   conn = connBean.getConn();
		   String sql = "select userid from members where useremail = ?";
		   pstmt = conn.prepareStatement(sql);
		   pstmt.setString(1, email);
		   res = pstmt.executeQuery();
		   if(res.next()){
			   String youid = res.getString("userid");
%>			   
	
<div class="row">
  <div class="col-12">
     
     <div class="bg-white rg findidpass">
       <h1 class="text-center py-5">아이디 찾기</h1>
 
       
       <div id="findidform">
          <ul class="registerul py-5">
             <li class="text-center py-5">
                 <%=email %> 님의 아이디는 <strong><%=youid %></strong> 입니다.
             </li>    
          </ul>
        </div>
     </div>
     
  </div>
</div>
<% 			   
		   }else{
			
	%>		   
		<script>
		  alert('<%=email %>은 등록되어 있지 않습니다.');
		  location.href="findidpass.jsp";
		</script>  
	<%		   
		   }
		   
	   }catch(SQLException | ClassNotFoundException e){
		   out.println("접속에러 : " + e.getMessage());
	   }finally{
			if(res != null) try {res.close();}catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {}
			if(conn != null) try {conn.close();}catch(SQLException e) {}
	   }
	   
   }else{
  %>	   
	  <script>
	    alert("이메일을 입력 하세요.");
	    location.href="findidpass.jsp";
	  </script> 
 <%	   
   }
 %>



<%@ include file="include/footer.jsp" %>
