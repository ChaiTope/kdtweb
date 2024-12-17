<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%
   String bbs = "list";
   if(request.getParameter("bbs")!=null && !request.getParameter("bbs").isEmpty()){
	   bbs = request.getParameter("bbs");
   }
   bbs= "/bbs/"+bbs+".jsp";
%>    
<%@ include file="include/header.jsp" %>
   <div class="bg-white bbs">
      <jsp:include page="<%=bbs %>"/>
   </div>
     

<%@ include file="include/footer.jsp" %>