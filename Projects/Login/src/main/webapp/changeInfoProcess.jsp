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
	
	public boolean idCheck(String id) {
		boolean idExist = false;
		getCon();
		
		try {
			pstmt = conn.prepareStatement("SELECT id FROM member WHERE id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if (rs.next()) idExist = true;
		} catch (Exception e) {
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
		return idExist;
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
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String gender = request.getParameter("gender");
		
		if(id.length() < 3 || id.length() > 10) {
	%>
	<script>
		alert('아이디 4~10글자로 입력해주세요');
		history.back();
	</script>
	<%
		} else if(!idCheck(id)) {
	%>
	<script>
		alert('<%=id %> 아이디는 존재하지 않습니다');
		history.back();
	</script>
	<%
		} else if(pwd.equals("")) {
	%>
	<script>
		alert('비밀번호를 입력해주세요');
		history.back();
	</script>
	<%
		} else if(name.equals("")) {
	%>
	<script>
		alert('이름을 입력해주세요');
		history.back();
	</script>
	<%
		} else {
			try {
				getCon();
				pstmt = conn.prepareStatement("update member set pwd=?, name=?, email=?, phone=?, gender=? where id = ?");
				pstmt.setString(1, pwd);
				pstmt.setString(2, name);
				pstmt.setString(3, email);
				pstmt.setString(4, phone);
				pstmt.setString(5, gender);
				pstmt.setString(6, id);
				pstmt.executeUpdate();
				out.println("<p>회원정보 수정 성공</p>");
				out.println("<p><a href=\"memberInfo.jsp\">변경된 정보보기</a></p>");
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
</body>
</html>