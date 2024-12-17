<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="kdtweb.dao.bbs.Board, kdtweb.beans.BoardDto,net.chaiyunsung.webjdbc01.util.Paging, java.sql.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    int totalRecords = 0;
    int recordsPerPage = 10;
    int pagesPerGroup = 10;
    int currentPage = 1;
    String searchKey = request.getParameter("searchKey");
    String searchWord = request.getParameter("searchWord");

    if (request.getParameter("pg") != null) {
        currentPage = Integer.parseInt(request.getParameter("pg"));
    }
    int limit = (currentPage - 1) * recordsPerPage;

    Board bbs = new Board();
    ArrayList<BoardDto> searchResults = null;

    try {
        // 검색어가 있는 경우 검색 기능을 실행
        if (searchWord != null && !searchWord.isEmpty()) {
            totalRecords = bbs.getSearchCount(searchKey, searchWord);
            searchResults = (ArrayList<BoardDto>) bbs.searchBoard(searchKey, searchWord, limit, recordsPerPage);
        } else {
            // 검색어가 없으면 기본 목록으로 이동하거나 처리
            response.sendRedirect("list.jsp");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    Paging paging = new Paging(totalRecords, recordsPerPage, currentPage, pagesPerGroup);
    request.setAttribute("paging", paging);
    request.setAttribute("searchResults", searchResults);
%>

<h1 class="text-center mb-5">검색 결과</h1>

<c:choose>
    <c:when test="${not empty searchResults}">
        <!-- 검색 결과가 있을 때 출력 -->
        <table class="bbslist table-hover">
            <colgroup>
                <col width="10%">
                <col width="50%">
                <col width="15%">
                <col width="15%">
                <col width="10%">
            </colgroup>
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>날짜</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="post" items="${searchResults}">
				    <tr>
				        <td class="text-center">${post.num}</td>
				        <td class="ellipsis">
				            <a href="bbs.jsp?mode=view&num=${post.num}&pg=${paging.currentPage}">${post.title}</a>
				        </td>
				        <td class="ellipsis text-center">${post.writer}</td>
				        <td class="text-center">${post.viewDate}</td>
				        <td class="text-center">${post.count}</td>
				    </tr>
				</c:forEach>
				
				<c:if test="${empty searchResults}">
				    <tr>
				        <td colspan="5" class="text-center">검색 결과가 없습니다.</td>
				    </tr>
				</c:if>
            </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <!-- 검색 결과가 없을 때 출력 -->
        <div class="alert alert-warning text-center">
            검색 결과가 없습니다.
        </div>
    </c:otherwise>
</c:choose>

<ul class="pagination justify-content-center">
    <li class="page-item">
        <a class="page-link bg-light" href="?pg=1">
            <i class="ri-arrow-left-double-line"></i>
        </a>
    </li>

    <!-- 이전 그룹 -->
    <c:if test="${paging.startPageOfGroup > 1}">
        <li class="page-item">
            <a class="page-link" href="?pg=${paging.startPageOfGroup - 1}">
                <i class="ri-arrow-left-s-line"></i>
            </a>
        </li>
    </c:if>

    <!-- 페이지 번호 -->
    <c:forEach var="i" begin="${paging.startPageOfGroup}" end="${paging.endPageOfGroup}">
        <li class='page-item <c:if test="${i == paging.currentPage}">active</c:if>'>
            <a class="page-link" href="?pg=${i}">${i}</a>
        </li>
    </c:forEach>

    <!-- 다음 그룹 -->
    <c:if test="${paging.endPageOfGroup < paging.totalPages}">
        <li class="page-item">
            <a class="page-link" href="?pg=${paging.endPageOfGroup + 1}">
                <i class="ri-arrow-right-s-line"></i>
            </a>
        </li>
    </c:if>
    
    <li class="page-item">
        <a class="page-link bg-light" href="?pg=${paging.totalPages}">
            <i class="ri-arrow-right-double-line"></i>
        </a>
    </li>
</ul>

