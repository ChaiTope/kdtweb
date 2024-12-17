<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="kdtweb.dao.bbs.Board" %>
<%@ page import="kdtweb.beans.BoardDto" %>
<%@ page import="java.sql.SQLException" %>

<h1 class="text-center mb-5">게시글 수정/삭제</h1>

<%
    long num = Long.parseLong(request.getParameter("num"));
    Board bbs = new Board();
    BoardDto boardDetail = null;

    try {
        boardDetail = bbs.viewBoard(num);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<% if (boardDetail != null) { %>
    <div class="container">
        <!-- 수정 폼 -->
        <form action="editProcess.jsp" method="post">
            <input type="hidden" name="num" value="<%= boardDetail.getNum() %>">
            
            <!-- 제목 -->
            <div class="form-group mb-2">
                <label for="title">제목</label>
                <input type="text" name="title" class="form-control" value="<%= boardDetail.getTitle() %>">
            </div>

            <!-- 내용 -->
            <div class="form-group mb-2">
                <label for="contents">내용</label>
                <textarea name="contents" class="form-control" rows="5"><%= boardDetail.getContents() %></textarea>
            </div>

            <!-- 작성자 -->
            <div class="form-group mb-2">
                <label for="writer">작성자</label>
                <input type="text" name="writer" class="form-control" value="<%= boardDetail.getWriter() %>">
            </div>

            <!-- 수정 및 삭제 버튼 -->
            <div class="d-flex justify-content-between">
                <!-- 수정 버튼 -->
                <button type="submit" class="btn btn-primary">수정 완료</button>
                
                <!-- 삭제 버튼 -->
                <button type="button" class="btn btn-danger" onclick="deleteBoard(<%= boardDetail.getNum() %>)">삭제</button>
            </div>
        </form>
    </div>

    <!-- 삭제 작업을 위한 JavaScript -->
    <script>
        function deleteBoard(num) {
            if (confirm("정말로 이 게시글을 삭제하시겠습니까?")) {
                window.location.href = "deleteProcess.jsp?num=" + num;
            }
        }
    </script>

<% } else { %>
    <div class="alert alert-danger">게시글을 찾을 수 없습니다.</div>
<% } %>
