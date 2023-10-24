<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .outer{
        background: black;
        color: white;
        height: auto;
        margin: auto;
        margin-top: 50px;
    }
    .list-area{
        max-width: 850px;
        margin: auto;
    }
    .thumbnail{
        display: inline-block;
        padding: 12px;
        margin: 14px;
        width: 220px;
        border: 1px solid white;
    }
    .thumbnail:hover{
        cursor: pointer;
        opacity: 0.8;
    }
</style>
</head>
<body>
    <%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">사진 게시판</h2>
        <br>
		
		<% if (loginUser != null) { %>
	        <div align="right" style="max-width: 850px; margin: auto;">
	            <a href="<%=contextPath %>/enrollForm.th" class="btn btn-sm btn-secondary">글작성</a>
	            <br><br>
	        </div>
        <% } %>

        <div class="list-area">
            <div class="thumbnail" align="center">
                <img width="200" height="150" src="http://localhost:8002/jsp/resources/board_upfile/2023102316502757665.jpg" alt="썸네일">
                <p>
                    No. 117 안녕하세요. <br>
                    조회수 : 555
                </p>
            </div>
            <div class="thumbnail" align="center">
                <img width="200" height="150" src="http://localhost:8002/jsp/resources/board_upfile/2023102316502757665.jpg" alt="썸네일">
                <p>
                    No. 117 안녕하세요. <br>
                    조회수 : 555
                </p>
            </div>
            <div class="thumbnail" align="center">
                <img width="200" height="150" src="http://localhost:8002/jsp/resources/board_upfile/2023102316502757665.jpg" alt="썸네일">
                <p>
                    No. 117 안녕하세요. <br>
                    조회수 : 555
                </p>
            </div>
            <div class="thumbnail" align="center">
                <img width="200" height="150" src="http://localhost:8002/jsp/resources/board_upfile/2023102316502757665.jpg" alt="썸네일">
                <p>
                    No. 117 안녕하세요. <br>
                    조회수 : 555
                </p>
            </div>
            <div class="thumbnail" align="center">
                <img width="200" height="150" src="http://localhost:8002/jsp/resources/board_upfile/2023102316502757665.jpg" alt="썸네일">
                <p>
                    No. 117 안녕하세요. <br>
                    조회수 : 555
                </p>
            </div>
        </div>
        

    </div>
</body>
</html>