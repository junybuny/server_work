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
        width: 1000px;
        height: 500px;
        margin: auto;
        margin-top: 50px;
    }
    .list-area{
        border: 1px solid white;
        text-align: center;
    }
</style>

</head>
<body>
    <%@ include file="../common/menubar.jsp" %>

    <div class="outer">
        <br>
        <h2 align="center">공지사항</h2>
        <br>

        <!-- 현재 로그인한 사용자가 관리자일 경우에 보여짐 -->
        <div align="right" style="width: 850px;">
            <a href="" class="btn btn-sm btn-secondary">글작성</a>
        </div>

        <table class="list-area" align="center">
            <thead>
                <th>글번호</th>
                <th width="400">글제목</th>
                <th width="100">작성자</th>
                <th>조회수</th>
                <th width="100">작성일</th>
            </thead>
            <tbody>
                <!-- case1 공지사항이 없을 경우 -->
                <tr>
                    <td colspan="5">존재하는 공지사항이 없습니다.</td>
                </tr>
                <!-- case2 공지사항이 있을 경우 -->
                <tr>
                    <td>3</td>
                    <td>세번째 공지사항 입니다.</td>
                    <td>admin</td>
                    <td>34</td>
                    <td>2023-10-16</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>두번째 공지사항 입니다.</td>
                    <td>admin</td>
                    <td>22</td>
                    <td>2023-09-14</td>
                </tr>
                <tr>
                    <td>1</td>
                    <td>첫번째 공지사항 입니다.</td>
                    <td>admin</td>
                    <td>56</td>
                    <td>2023-09-05</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>