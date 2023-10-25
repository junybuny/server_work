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
        height: auto;
        margin: auto;
        margin-top: 50px;
    }
    .outer table{
        border: 1px solid white;
        border-collapse: collapse;
    }
    .outer table tr, .outer table td{
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
            <a href="<%=contextPath %>/list.bo?cpage=1" class="btn btn-sm btn-secondary">목록가기</a>
			
			<% if (loginUser != null && loginUser.getUserId().equals(b.getBoardWriter())) { %>
	            <!-- 로그인한 사용자(loginUser)가 게시글(b)의 작성자일 경우 사용가능 -->
	            <a href="<%=contextPath %>/updateForm.bo?bno=<%=b.getBoardNo()%>" class="btn btn-sm btn-warning">수정하기</a>
	            <a href="" class="btn btn-sm btn-danger">삭제하기</a>
            <% } %>
        </div>

        <br>
        <div id="reply-area">
            <table align="center">
                <thead>
                    <tr>
                        <th>댓글작성</th>
                        <td>
                            <textarea id="reply-content" cols="50" rows="3"></textarea>
                        </td>
                        <td>
                            <button onclick="insertReply()">댓글등록</button>
                        </td>
                    </tr>
                </thead>
                <tbody>
                    
                </tbody>
            </table>

            <script>
                window.onload = function(){
                    // 댓글 가져와서, 그려주기
                    selectReplyList();
                }

                function selectReplyList(){
                    $.ajax({
                        url: "rlist.bo",
                        data: {
                            bno: <%=b.getBoardNo()%>
                        },
                        success: function(res){
                        	let str = "";
                        	for (let reply of res) {
                        		str += "<tr>"
                     				+ "<td>" + reply.replyWriter + "</td>"
                     				+ "<td>" + reply.replyContent + "</td>"
                     				+ "<td>" + reply.createDate + "</td>"
                     				+ "</tr>";
                        	}
                        	
                        	document.querySelector("#reply-area tbody").innerHTML = str;
                        	
                        	
                        },
                        error: function(){
                            console.log("댓글 목록 조회 실패")
                        }

                    })
                }

                function insertReply(){
                    $.ajax({
                        url: "rinsert.bo",
                        data: {
                            content: document.getElementById("reply-content").value,
                            bno: <%=b.getBoardNo()%>
                        },
                        type: "post",
                        success: function(res){
                        	if (res > 0) {//댓글작성 성공
                            	document.getElementById("reply-content").value = "";
                            	selectReplyList();
                            }
                        },
                        error:function(){
							console.log("댓글 작성중 ajax통신 실패")
                        }
                    })
                }

            </script>
        </div>
    </div>
</body>
</html>