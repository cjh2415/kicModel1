<%@page import="model.Board"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String path = application.getRealPath("/")+"/boardupload/";
int size=10*1024*1024;
MultipartRequest multi = new MultipartRequest(request,path,size,"UTF-8");
Board board = new Board();
board.setPass(multi.getParameter("pass"));
board.setSubject(multi.getParameter("subject"));
board.setContent(multi.getParameter("content"));
board.setFile1(multi.getFilesystemName("file1"));
board.setNum(Integer.parseInt(multi.getParameter("num")));
//int num = Integer.parseInt(request.getParameter("num"));
BoardDao bd = new BoardDao();

//파일 수정시 수정이 발생하지 않은 경우
if(board.getFile1()==null||board.getFile1().equals("")){
	board.setFile1(multi.getParameter("file2"));
}
Board dbboard = bd.boardOne(board.getNum());
//Board asd = bd.boardOne(num);

String msg = "비밀번호가 틀렸습니다.";
String url = "boardUpdateForm.jsp?num="+board.getNum();
if(board.getPass().equals(dbboard.getPass())){		//비밀번호 일치
	if(bd.boardUpdate(board)>0){		//수정성공 
		msg="수정완료";
		url="boardInfo.jsp?num="+board.getNum();
	}else{		//수정실패
		msg="수정실패";
		url="boardUpdateForm.jsp?num="+board.getNum();
	}
}
%>
<script>
alert("<%=msg%>")
location.href="<%=url%>"
</script>
</body>
</html>