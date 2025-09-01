<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String db_address = "jdbc:mysql://localhost:3306/board";
		String db_username = "root";
		String db_pwd = "1234";
		Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
		request.setCharacterEncoding("UTF-8");
		
		Timestamp today_date = new Timestamp(System.currentTimeMillis());
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		int num = 0;
		PreparedStatement psmt = connection.prepareStatement("select max(num) from post");
		ResultSet result = psmt.executeQuery();
		
		while(result.next()) {
			num = result.getInt("max(num)") + 1;
		}
		
		psmt = connection.prepareStatement("insert into post(num, title, writer, content, reg_data) values (?, ?, ?, ?, ?)");
		psmt.setInt(1, num);
		psmt.setString(2, title);
		psmt.setString(3, writer);
		psmt.setString(4, content);
		psmt.setTimestamp(5, today_date);
		psmt.executeUpdate();
		
		response.sendRedirect("post_list.jsp");
	} catch (Exception e) {
		out.println("오류가 발생했습니다. 오류 메세지 : " + e.getMessage());
	}
%>