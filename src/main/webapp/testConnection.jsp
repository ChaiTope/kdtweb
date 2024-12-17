<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="kdtweb.dao.MySqlConnect" %>

<html>
<head>
    <meta charset="UTF-8">
    <title>DB 연결 테스트</title>
</head>
<body>
<%
    MySqlConnect dbConnect = new MySqlConnect();
    Connection conn = null;
    String message = "";

    try {
        conn = dbConnect.getConn();
        if (conn != null) {
            message = "DB 연결 성공";
        } else {
            message = "DB 연결 실패";
        }
    } catch (ClassNotFoundException e) {
        message = "JDBC 드라이버 로드 실패: " + e.getMessage();
    } catch (SQLException e) {
        message = "DB 연결 실패: " + e.getMessage();
    } finally {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            message = "연결 종료 실패: " + e.getMessage();
        }
    }
%>

    <h1><%= message %></h1>

</body>
</html>

