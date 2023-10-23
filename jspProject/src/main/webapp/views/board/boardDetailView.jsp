<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.kh.board.model.vo.Board, com.kh.common.model.vo.Attachment"%>
<%
	Board b = (Board)request.getAttribute("b");

	Attachment at = (Attachment)request.getAttribute("at");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer{
        background: black;
        color: white;
        width: 1000px;
        height: 500px;
        margin: auto;
        margin-top: 50px;
    }
    .outer > table{
        border: 1px solid white;
        border-collapse: collapse;
    }
    .outer > table tr, .outer > table td{
        border: 1px solid white;
    }
</style>
</head>
<body>
    <%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">일반게시판 상세보기</h2>
        <br>

        <table id="detail-area" border="1" align="center">
            <tr>
                <th width="70">카테고리</th>
                <td width="70"><%=b.getCategory() %></td>
                <th width="70">제목</th>
                <td width="350"><%=b.getBoardTitle() %></td>
            </tr>
            <tr>
                <th>작성자</th>
                <td><%=b.getBoardWriter() %></td>
                <th>작성일</th>
                <td><%=b.getCreateDate() %></td>
            </tr>
            <tr>
                <th>내용</th>
                <td colspan="3">
                    <p style="height: 200px;"><%=b.getBoardContent() %></p>
                </td>
            </tr>
            <tr>
                <th>첨부파일</th>
                <td colspan="3">
                	<% if (at == null) { %>
	                    <!-- case1. 첨부파일이 없을경우 -->
	                    첨부파일이 없습니다.
                    <% } else { %>
	                    <!-- case2. 첨부파일이 있을경우 -->
	                    <a download=<%=at.getOriginName() %> href="<%=contextPath %>/<%=at.getFilePath() + at.getChangeName() %>"><%=at.getOriginName() %></a>
                    <% } %>
                </td>
            </tr>
        </table>
        <br>
        <div align="center">
            <a href="" class="btn btn-sm btn-secondary">목록가기</a>
			
			<% if (loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
	            <!-- 로그인한 사용자(loginUser)가 게시글(b)의 작성자일 경우 사용가능 -->
	            <a href="" class="btn btn-sm btn-warning">수정하기</a>
	            <a href="" class="btn btn-sm btn-danger">삭제하기</a>
            <% } %>
        </div>

    </div>
</body>
</html>