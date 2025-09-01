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
	<title>회원정보 보기</title>
	<style>
		body {
			font-family: 'Arial', sans-serif;
			background-color: #f4f4f4;
			margin: 0;
			padding: 20px;
		}
		h1 {
			text-align: center;
			color: #333;
		}
		form {
			text-align: center;
			margin-bottom: 20px;
		}
		select {
			width: 80px;
			padding: 8px;
		}
		input[type="text"] {
			padding: 8px;
			width: 200px;
		}
		input[type="submit"] {
			padding: 8px 16px;
			background-color: #007BFF;
			color: white;
			border: none;
			cursor: pointer;
			border-radius: 8px;
		}
		input[type="submit"]:hover {
			background-color: #0056b3;
		}
		table {
			width: 80%;
			margin: 0 auto;
			border-collapse: collapse;
			background-color: #fff;
			box-shadow: 0 0 10px rgba(0,0,0,0.1);
		}
		th, td {
			border: 1px solid #ddd;
			padding: 12px;
			text-align: center;
		}
		th {
			background-color: #007BFF;
			color: white;
		}
		tr:nth-child(even) {
			background-color: #f9f9f9;
		}
		.member-container {
			display: flex;
			flex-wrap: wrap;
			justify-content: center;
			gap: 20px;
		}
		
		.member-card {
			background-color: #ffffff;
			border: 1px solid #ddd;
			border-radius: 8px;
			box-shadow: 0 2px 6px rgba(0,0,0,0.1);
			padding: 20px;
			width: 250px;
			transition: transform 0.2s;
		}
		
		.member-card:hover {
			transform: translateY(-5px);
		}
		
		.member-card h2 {
			margin-top: 0;
			color: #007BFF;
		}
		
		.member-card p {
			margin: 8px 0;
			color: #333;
		}
			
	</style>
</head>
<body>
	<h1>회원정보 보기</h1>
	<div class="member-container">
	<%
		getCon();
		String cat = request.getParameter("cat");
		String search = request.getParameter("search");
		search = (search == null) ? "":search;
	
		try {
			int num = 1;
			if(!search.equals("")) {
				pstmt = conn.prepareStatement("SELECT id, name, email FROM member WHERE " + cat + " LIKE ?");
				pstmt.setString(1, "%"+search+"%");
			} else {
				pstmt = conn.prepareStatement("SELECT id, name, email FROM member");	
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
	%>
	<div class="member-card">
		<h2>회원 <%= num++ %></h2>
		<p><strong>ID:</strong> <%= rs.getString(1) %></p>
		<p><strong>이름:</strong> <%= rs.getString(2) %></p>
		<p><strong>이메일:</strong> <%= rs.getString(3) %></p>
	</div>
	<%
				num++;
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
	</div>
	
	<form action="memberList.jsp" method="GET">
		검색어
		<select name="cat">
			<option value="id">ID</option>
			<option value="name">NAME</option>
			<option value="email">EMAIL</option>
		</select>
		<input type="text" name="search" autocomplete="off"> <input type="submit" value="검색">
	</form>
</body>
</html>