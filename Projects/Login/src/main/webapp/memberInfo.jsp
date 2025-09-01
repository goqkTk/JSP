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
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>사용자 상세정보</title>
</head>
<body>
	<%if(session.getAttribute("id") == null) { %>
	<a href="login.jsp">로그인</a>이 필요합니다
	
	<%
		} else {
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
	<h2>사용자 상세정보</h2>
	아이디 : <%=rs.getString(1) %><br>
	비밀번호 : <%=rs.getString(2) %><br>
	이름 : <%=rs.getString(3) %><br>
	이메일 : <%=rs.getString(4) %><br>
	전화번호 : <%=rs.getString(5) %><br>
	성별 : <%=rs.getString(6) %><br>
	<a href="changeInfo.jsp">[회원정보 수정]</a>
	<a href="delInfo.jsp">[회원 탈퇴하기]</a><br>
	<a href="index.jsp">[메인 페이지]</a>
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
		}
	%>
</body>
</html>