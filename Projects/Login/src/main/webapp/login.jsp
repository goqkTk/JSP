<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
</head>
<body>
	<form action="loginProcess.jsp" method="post">
		아이디 <input type="text" name="id"><br>
		패스워드 <input type="password" name="pwd"><br>
		<input type="submit" value="로그인">
	</form>
	<a href="index.jsp">메인페이지로 돌아가기</a>
</body>
</html>