<%@page import="model.Board"%>
<%@page import="service.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
int num = Integer.parseInt(request.getParameter("num"));
BoardDao bd = new BoardDao();
Board b = bd.boardOne(num);



%>
<hr>
	<div class="container">
	<form action="boardReplyPro.jsp" name="f"  method="post">
	<input type="hidden" name="num" value="<%=b.getNum()%>">
	<input type="hidden" name="ref" value="<%=b.getRef()%>">
	<input type="hidden" name="reflevel" value="<%=b.getReflevel()%>">
	<input type="hidden" name="refstep" value="<%=b.getRefstep()%>">
		<h2 id="center">게시판 답글</h2>
				<div class="form-group">
					<label>작성자:</label>
					<input type="text" class="form-control" name="writer">
					<label>비밀번호:</label>
					<input type="password" class="form-control" name="pass"> 
					<label>제목:</label>
					<input type="text" class="form-control"	name="subject" value="re:<%=b.getSubject()%>">
				</div>
		<div class="form-group">
		<label>내용</label>
		<textarea class="form-control" rows="10" cols="50" name="content"></textarea>
		</div>
		<div id = "center" style="padding: 3px;">
		<button type="submit" class="btn btn-dark">입력</button>
		</div>
		</form>
		</div>
</body>
</html>