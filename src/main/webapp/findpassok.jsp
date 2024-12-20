<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"   
 %>
<%@ include file="include/header.jsp" %>
<jsp:useBean id="connBean" class="kdtweb.dao.MySqlConnect" scope="page" />
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet res = null;
	
	String email = request.getParameter("useremail");
	String userid = request.getParameter("userid");
	
	if((email != null && !email.isEmpty()) && (userid != null && !userid.isEmpty())){
	   try{
		   conn = connBean.getConn();
	       String sql = "select userid from members where useremail = ? and  userid = ?";
	       pstmt = conn.prepareStatement(sql);
	       pstmt.setString(1, email);
	       pstmt.setString(2, userid);
	       res = pstmt.executeQuery();
		   
	       if(res.next()){
	    	   
	    	   int id = res.getInt("id");
	    	   String newPass="";
	    	   String chars="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	    	   for(int i = 0; i < 7; i++){
	    		   newPass += chars.charAt((int)(Math.random()*chars.length()));
	    	   }
	    	   sql = "Update members SET userpass = ? where id = ?";
	    	   pstmt = conn.prepareStatement(sql);
	    	   pstmt.setString(1, newPass);
	    	   pstmt.setInt(2, id);
	    	   
	    	   int uc =pstmt.executeUpdate();
	    	   //이메일 전송
	    	   
	    	   String html = "<div class=\"row\">\r\n"
	    				+ "  <div class=\"col-12\">\r\n"
	    				+ "     \r\n"
	    				+ "     <div class=\"bg-white rg findidpass\">\r\n"
	    				+ "       <h1 class=\"text-center py-5\">아이디 찾기</h1>\r\n"
	    				+ " \r\n"
	    				+ "       \r\n"
	    				+ "       <div id=\"findidform\">\r\n"
	    				+ "          <ul class=\"registerul py-5\">\r\n"
	    				+ "             <li class=\"text-center py-5\">\r\n"
	    				+ "                 aaa 님의 비밀번호는<strong>"+newPass+"</strong>입니다.\r\n"
	    				+ "             </li>    \r\n"
	    				+ "          </ul>\r\n"
	    				+ "        </div>\r\n"
	    				+ "     </div>\r\n"
	    				+ "     \r\n"
	    				+ "  </div>\r\n"
	    				+ "</div>\r\n"
	    				+ "\r\n"
	    				+ "</div>";
   				out.println(html);
	    	   
	       }else{
	    	   String alert = "<script>alert('이메일 또는 아이디가 일치하지 않아요');location.href='findidpass.jsp';</script>";
	    	   out.println(alert);
	       }
	   }catch(SQLException | ClassNotFoundException e){
		   out.println("접속에러 : " + e.getMessage());
	   }
	}
	else{
		%>
		<script>
		alert("아이디와 이메일을 입력해주세요");
		location.href="findidpass.jsp";
		</script>
		
		<%
	}
%>
</div>
<%@ include file="include/footer.jsp" %>
