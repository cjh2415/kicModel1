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
String pass = request.getParameter("pass");
BoardDao bd = new BoardDao();
Board board = bd.boardOne(num);
String msg = "비밀번호가 일치하지 않습니다.";
String url = "boardDeleteForm.jsp?num="+num;

//비밀번호 확인 
if(pass.equals(board.getPass())){	//비밀번호가 일치 하면
	if(bd.boardDelete(num)>0){	//삭제가 정상적으로 되었을 경우
		msg = "게시글이 삭제 되었습니다.";
	}else{						//삭제 오류 발생
		msg = "게시글 삭제 오류";
	}
	url = "list.jsp";
}
%>
<script>
alert("<%=msg%>")
location.href = "<%=url%>"
</script>
</body>
</html>