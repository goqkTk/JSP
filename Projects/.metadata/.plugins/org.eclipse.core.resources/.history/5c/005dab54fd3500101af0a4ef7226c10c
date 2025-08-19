<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>메인</title>
</head>
<body>
	<%
		if(session.getAttribute("id") == null) {
	%>
	<a href="login.jsp">로그인</a>이 필요합니다
	<% } else { %>
	<%=session.getAttribute("id") %>님 반갑습니다<br>
	이 문장은 로그인한 사용자만 볼 수 있습니다<br>
	세션 저장값 : <%=session.getAttribute("id") %><br>
	세션 아이디 : <%=session.getId() %><br>
	세션 유효시간 : <%=session.getMaxInactiveInterval() %><br>
	<a href="memberInfo.jsp">사용자 상세정보 보기</a>
	<a href="logout.jsp">로그아웃</a>
	<%} %>
</body>
</html>