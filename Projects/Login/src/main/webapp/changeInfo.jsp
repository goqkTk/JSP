<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
	String dbURL = "jdbc:mysql://localhost:3306/login?useUnicode=true&characterEncoding=utf8&serverTimezone=UTC";
	String dbUser = "root";
	String dbPassword = "1234";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public void getCon() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원정보 수정</title>
</head>
<body>
	<%
		getCon();
		String id = (String)session.getAttribute("id");
		String pwd = null;
		String name = null;
		String email = null;
		String phone = null;
		String gender = null;
		
		try {
			pstmt = conn.prepareStatement("select id, pwd, name, email, phone, gender from member where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
	%>
	<h2>사용자 정보 수정하기</h2>
	<form action="changeInfoProcess.jsp" method="post">
		아이디 : <%=rs.getString(1) %>
		<input type="hidden" name="id" value="<%=rs.getString(1) %>"><br>
		비밀번호 : <input type="password" name="pwd"><br>
		이름 : <input type="text" name="name" value="<%=rs.getString(3) %>"><br>
		이메일 : <input type="text" name="email" value="<%=rs.getString(4) %>"><br>
		전화번호 : <input type="text" name="phone" value="<%=rs.getString(5) %>"><br>
		성별 : <%=rs.getString(6) %>
		<input type="hidden" name="gender" value="<%=rs.getString(6) %>"><br>
		<input type="submit" value="회원정보 수정하기"><br>
	</form>
	
	<a href="index.jsp">[메인 페이지로]</a>
	<a href="logout.jsp">[로그아웃]</a>
	<%
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
				if(rs != null) rs.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	%>
</body>
</html>