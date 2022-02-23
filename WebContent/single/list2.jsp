<%@page import="java.util.List"%>
<%@page import="model.Board"%>
<%@page import="service.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Insert title here</title>
<style>
body {font-family: "Times New Roman", Georgia, Serif;}
h1, h2, h3, h4, h5, h6 {
  font-family: "Playfair Display";
  letter-spacing: 5px;
}
</style>
</head>
<script>
<%
String boardid = "1";
int limit = 3;			//한 페이지당 보여지는 게시글 갯수
int pageInt = 1;
try{
	pageInt = Integer.parseInt(request.getParameter("pageNum"));
}catch(Exception e){
	pageInt = 1;
}

BoardDao bd = new BoardDao();
int boardcount = bd.boardCount(boardid);
List<Board> list = bd.boardList(pageInt, limit, boardcount, boardid);

int bottomLine = 3;		//페이지 넘기기 갯수
int startPage = (pageInt-1)/bottomLine*bottomLine+1;
int endPage = (pageInt-1)/bottomLine*bottomLine+3;
int maxPage = (boardcount/limit) + (boardcount%limit==0?0:1);
if(endPage>maxPage) endPage=maxPage;
%>

</script>
<body>
<!-- header start-->
<div class="w3-top">
  <div class="w3-bar w3-white w3-padding w3-card" style="letter-spacing:4px;">
    <a href="<%=request.getContextPath()%>/view/main.jsp" class="w3-bar-item w3-button">KIC 캠퍼스</a>
    <!-- Right-sided navbar links. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
    <%
		String userInfo = (String)session.getAttribute("memberId");
		if(userInfo==null){	/* 로그인이 되어있지 않음 */
			%>
			<a href="<%=request.getContextPath()%>/view/member/sign_upPage.jsp" class="w3-bar-item w3-button">회원가입</a>
		    <a href="<%=request.getContextPath()%>/view/member/loginPage.jsp" class="w3-bar-item w3-button">로그인</a>	
		<%}else{%>	<!-- //로그인이 되어있음 -->
			<a href="<%=request.getContextPath()%>/view/Temporary.jsp" class="w3-bar-item w3-button">정보수정</a>
		    <a href="<%=request.getContextPath()%>/view/member/logout.jsp" class="w3-bar-item w3-button">로그아웃</a>
		    <%} %>
      <a href="<%=request.getContextPath()%>/single/list2.jsp?boardid=1" class="w3-bar-item w3-button">공지사항</a>
      <a href="<%=request.getContextPath()%>/single/list2.jsp?boardid=2" class="w3-bar-item w3-button">자유게시판</a>
      <a href="<%=request.getContextPath()%>/single/list2.jsp?boardid=3" class="w3-bar-item w3-button">QnA</a>
    </div>
  </div>
</div>
<!-- header end -->

<!-- contents start -->
<div class="w3-content" style="max-width:1100px">
<div class="w3-container">
<br><br><br><br>
  <h2 align="center">자유게시판</h2>

  <table class="w3-table-all" border="1">
  <tr>
  	<td colspan="6" class="w3-right-align">글개수:<%=boardcount %></td>
  	</tr>

      <tr class="w3-blue">
        <td class="center" width="70px">번호</td>
        <td class="center">제목</td>
        <td class="center" width="130px">작성자</td>
        <td class="center" width="150px">등록일</td>
        <td class="center" width="120px">파일</td>
        <td width="5px"></td>
      </tr>
	<%for(Board b : list){%>
	<tr>
      <td class="center"><%=b.getNum() %></td>
      <td class="title"><a href="<%=request.getContextPath()%>/view/board/boardInfo.jsp?num=<%=b.getNum()%>"><%=b.getSubject() %></a></td>
      <td class="center"><%=b.getWriter() %></td>
      <td class="center"><%=b.getRegdate() %></td>
      <td class="center"><%=b.getFile1() %></td>
      <td class="center"><%=b.getReadcnt() %></td>
    </tr>
	<%}%>
  </table>
  <div class="w3-bar" align="center">
  <button type="button" onclick="location.href = '<%=request.getContextPath()%>/single/list2.jsp?pageNum=<%=startPage-bottomLine%>'" class="w3-button" <%if(startPage <= bottomLine){ %>disabled<%}%>>&laquo;</button>
  <%for(int i = startPage; i<=endPage; i++){%>
	  <a href="<%=request.getContextPath()%>/single/list2.jsp?pageNum=<%=i %>" class="w3-button"><%=i %></a>
  <%}%>
  <button type="button" onclick="location.href = '<%=request.getContextPath()%>/single/list2.jsp?pageNum=<%=startPage+bottomLine%>'" class="w3-button" <%if(endPage >= maxPage){ %>disabled<%}%>>&raquo;</button>
</div>
</div>
</div>
<!-- contents end -->
</body>
</html>