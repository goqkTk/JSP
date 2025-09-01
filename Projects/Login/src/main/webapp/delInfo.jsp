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
<%
	if(session.getAttribute("id") == null) {
%>
<a href="login.jsp">로그인</a>이 필요한 페이지입니다
<%
	} else {
		getCon();
		String id = (String)session.getAttribute("id");
		try {
			pstmt = conn.prepareStatement("delete from member where id = ?");
			pstmt.setString(1, id);
			pstmt.executeUpdate();
			session.invalidate();
			out.println("<p>로그아웃 완료</p>");
			out.println("<p>회원정보 삭제 성공</p>");
			out.println("<p><a href=\"login.jsp\">로그인 페이지로 이동</a>");
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
%>