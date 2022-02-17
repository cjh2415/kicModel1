<%@page import="model.Member"%>
<%@page import="service.MemberDao"%>
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
String login = (String)session.getAttribute("memberId");
String msg = "";
String url = "";
//login 불가 이면
if(login == null||login.trim().equals("")){
	%>
	<script>
	alert("로그인이 필요 합니다")
	location.href="<%=request.getContextPath()%>/view/member/loginForm.jsp";
	</script>
<%} else{
	MemberDao md = new MemberDao();
	Member mem =  md.selectOne(login);
	String pass = request.getParameter("pass");
	String newpass = request.getParameter("newpass");
	if(pass.equals(mem.getPass())){	//비밀번호 일치
		if(md.changePass(login,newpass)>0){	//변경됨
			msg="비밀번호가 수정 되었습니다.";
			url="main.jsp";
		} else{	//변경안됨
			msg="비밀번호 변경 오류 발생.";
			url="main.jsp";
		}
	}else{	//비밀번호 불일치
		msg="비밀번호가 일치하지 않습니다.";
		url="member/passwordForm.jsp";
	}
	
	
	
}%>
<script>
alert("<%=msg%>")
location.href="<%=request.getContextPath()%>/view/<%=url%>"
</script>
</body>
</html>