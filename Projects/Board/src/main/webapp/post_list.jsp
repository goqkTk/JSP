<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 목록</title>
</head>
<body>
	<h1>게시글 목록</h1>
	<%
		Connection connection = null;
		PreparedStatement psmt = null;
		ResultSet result = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			String db_address = "jdbc:mysql://localhost:3306/board";
			String db_username = "root";
			String db_pwd = "1234";
			connection = DriverManager.getConnection(db_address, db_username, db_pwd);
			
			psmt = connection.prepareStatement("select * from post order by num desc");
			result = psmt.executeQuery();
	%>
	<table border="1">
		<tr>
			<td colspan="5">
				<h3>게시글 제목 클릭시 상세 열람 가능</h3>
			</td>
		</tr>
		<tr>
			<td colspan="5">
				<button type="button" value="신규 글 작성" onClick="location.href='post_new.jsp'">신규 글 작성</button>
			</td>
		</tr>
		<tr>
			<td>번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
			<td>관리</td>
		</tr>
		<%
			while(result.next()) {
		%>
		<tr>
			<td><%=result.getInt("num") %></td>
			<td><%=result.getString("writer") %></td>
			<td><a href="post_read.jsp?num=<%=result.getInt("num") %>"><%=result.getString("title") %></a></td>
			<td><%=result.getTimestamp("reg_data") %></td>
			<td>
				<button type="button" onClick="location.href='post_modify.jsp?num=<%=result.getInt("num") %>'">수정</button>
				<button type="button" onClick="location.href='post_delete_send.jsp?num=<%=result.getInt("num") %>'">삭제</button>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		} catch(Exception e) {
			out.println("오류가 발생했습니다. 오류 메시지 : " + e.getMessage());
		}
	%>
</body>
</html>