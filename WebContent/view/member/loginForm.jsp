<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<hr>
	<!-- login start -->
	<div class="container">
		<h2   id="center">로그인</h2>
		<form action="<%=request.getContextPath() %>/view/member/LoginPro.jsp" method="post">
		<div class="form-group">
			<label for="usr">Name:</label>
			<input type="text" class="form-control" id="usr" name="id">
			<label for="pwd">Password:</label>
			<input type="password" class="form-control" id="pwd" name="pass">
		</div>
		<div id="center" style="padding: 3px;">
			<button type="submit" class="btn btn-dark">로그인</button>
		</div>
		</form>
	</div>
</body>
</html>