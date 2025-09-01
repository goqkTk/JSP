<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%!
	String dbURL = "jdbc:mysql://localhost:3306/login?useUnicode=true&characterEncoding=UTF-8";
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
			
			if (rs.next()) {
				idExist = true;
			}
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
	<title>use DB register</title>
	<%
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String pwd = request.getParameter("pwd");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone1") + "-" + request.getParameter("phone2") + "-" + request.getParameter("phone3");
		String gender = request.getParameter("gender");
		
		if(id.length()<4 || id.length()>10) {
	%>
	<script>
		alert('아이디는 4~10글자로 입력해주세요');
		history.back();
	</script>
	<% } else if (idCheck(id)) { %>
	<script>
		alert('<%=id %> 아이디는 이미 사용중입니다');
		history.back();
	</script>
	<% } else if(pwd.equals("")) { %>
	<script>
		alert('비밀번호를 입력해주세요');
		history.back();
	</script>
	<% } else if(name.equals("")) { %>
	<script>
		alert('이름을 입력해주세요');
		history.back();
	</script>
	<%
		} else {
			try {
				getCon();
				pstmt = conn.prepareStatement("INSERT INTO member VALUES (?, ?, ?, ?, ?, ?)");
				pstmt.setString(1, id);
				pstmt.setString(2, pwd);
				pstmt.setString(3, name);
				pstmt.setString(4, email);
				pstmt.setString(5, phone);
				pstmt.setString(6, gender);
				pstmt.executeUpdate();
				out.println("<p>회원가입 성공!");
				out.println("<p><a href=\"memberList.jsp\">회원정보 리스트</a> 보기");
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(pstmt != null) pstmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	%>
</head>
<body>
	<h1>회원가입 입력 내역</h1>
	<p>아이디 : <%= id %>
	<p>비밀번호 : <%= pwd %>
	<p>이름 : <%= name %>
	<p>이메일 : <%= email %>
	<p>전화번호 : <%= phone %>
	<p>성별 : <%= gender %>
</body>
</html>