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
request.setCharacterEncoding("UTF-8");
String id = request.getParameter("id");
String pass = request.getParameter("pass");
MemberDao md = new MemberDao();
//id가 없으면 null값 리턴
Member mem =  md.selectOne(id);
String msg = "아이디를 확인 하세요";
String url = request.getContextPath()+"/view/member/loginForm.jsp";

//id 존재&비번 일치
if(mem!=null){
	if(pass.equals(mem.getPass())){
		session.setAttribute("memberId", id);
		msg = mem.getName()+"님이 로그인에 성공하였습니다.";	
		url = request.getContextPath()+"/view/main.jsp";
	}else{
		msg = "비밀번호를 확인 하세요";
	}
}
%>
<script>
alert("<%=msg %>")
location.href="<%=url %>"
</script>
</body>
</html>