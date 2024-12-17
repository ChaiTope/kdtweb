<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kdtweb.dao.bbs.Board" %>
<%@ page import="kdtweb.beans.BoardDto" %>
<%@ page import="java.sql.SQLException" %>

<h1 class="text-center mb-5">게시글 상세보기</h1>


<%  
	String stringNum = request.getParameter("num");
	if(stringNum != null && !stringNum.isEmpty()){
	long num = Long.parseLong(stringNum);
    Board bbs = new Board();
    BoardDto boardDetail = null;

    try {
        boardDetail = bbs.viewBoard(num);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

    <div class="container">
        <!-- 제목 -->
        <div class="post-title mb-2">
            <h1><%= boardDetail.getTitle() %></h1>
        </div>

        <!-- 작성자, 날짜, 조회수 -->
        <div class="post-info mb-2 text-muted">
            <span class="me-3 pr-2">작성자: <strong><%= boardDetail.getWriter() %></strong></span>
            <span class="me-3 px-2"> 작성일: <%= boardDetail.getWdate() %></span>
            <span class="px-2"> 조회수: <%= boardDetail.getCount() %></span>
        </div>

        <!-- 본문 내용 (min-height 적용) -->
        <div class="post-content">
            <%= boardDetail.getContents() %>
        </div>

        <!-- 목록으로 돌아가기 버튼 -->
        <div class="mb-4">
	        <div class="float-right d-inline-block">
	            <a href="bbs.jsp?bbs=list" class="btn btn-secondary">목록</a>
	        </div>
	        <div class="float-left d-inline-block mr-2">
	            <a href="bbs.jsp?bbs=pass" class="btn btn-primary">수정</a>
	        </div>
	        <div class="float-left d-inline-block">
	            <a href="bbs.jsp?bbs=list" class="btn btn-danger">삭제</a>
	        </div>
        </div>
    </div>

<% } else { %>
	<div class="error-container">
	    <div class="alert alert-danger">게시글을 찾을 수 없습니다.</div>
    </div>
<% } %>

