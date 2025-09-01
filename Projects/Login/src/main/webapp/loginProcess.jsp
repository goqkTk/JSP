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
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public boolean idCheck(String id, String pwd) {
		getCon();
		boolean auth = false;
		try {
			pstmt = conn.prepareStatement("select id from member where id = ? and pwd = ?");
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) auth = true;
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
		return auth;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		
		if(idCheck(id, pwd)) {
			session.setAttribute("id", id);
			response.sendRedirect("index.jsp");
		} else {
	%>
	<script>
		alert("아이디나 패스워드가 올바르지 않습니다");
		history.back();
	</script>
	<%
		}
	%>
</head>
<body>
	
</body>
</html>