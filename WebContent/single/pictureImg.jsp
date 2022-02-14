<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
String path = application.getRealPath("/")+"upload/";
String filename= null;

MultipartRequest multi = new MultipartRequest(request, path, 10*1024*1024, "UTF-8");
filename = multi.getFilesystemName("picture");
%>
<script>
const img = opener.document.querySelector("#pic");
img.src="<%=request.getContextPath()%>/upload/<%=filename%>"
opener.document.f.picture.value="<%=filename%>"
self.close()




</script>
</body>
</html>