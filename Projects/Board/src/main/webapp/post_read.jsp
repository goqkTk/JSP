<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 읽기</title>
</head>
<body>
	<h1>게시글 읽기</h1>
	<%
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String db_address = "jdbc:mysql://localhost:3306/board";
			String db_username = "root";
			String db_pwd = "1234";
			Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
			request.setCharacterEncoding("UTF-8");
			String num = request.getParameter("num");
			PreparedStatement psmt = connection.prepareStatement("select * from post where num=" + num);
			ResultSet result = psmt.executeQuery();
	%>
	<table border="1">
	<%
		while(result.next()) {
	%>
	<tr>
		<td>번호</td>
		<td><%=result.getInt("num") %></td>
	</tr>
	<tr>
		<td>작성일</td>
		<td><%=result.getTimestamp("reg_data") %></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><%=result.getString("writer") %></td>
	</tr>
	<tr>
		<td>제목</td>
		<td><%=result.getString("title") %></td>
	</tr>
	<tr>
		<td>내용</td>
		<td><%=result.getString("content") %></td>
	</tr>
	<tr>
		<td colspan="2">
			<button type=button onclick="location.href='post_list.jsp'">목록으로</button>
		</td>
	</tr>
	<%
		}
	%>
	</table>
	<%
		} catch (Exception e){
		out.println("오류가 발생했습니다. 오류 메시지 : " + e.getMessage());
		}
	%>
</body>
</html>