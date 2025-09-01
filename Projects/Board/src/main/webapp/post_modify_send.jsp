<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		String db_address = "jdbc:mysql://localhost:3306/board";
		String db_username = "root";
		String db_pwd = "1234";
		Connection connection = DriverManager.getConnection(db_address, db_username, db_pwd);
		request.setCharacterEncoding("UTF-8");
		String writer = request.getParameter("writer");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String num = request.getParameter("num");
		PreparedStatement psmt = connection.prepareStatement("select * from post where num=" + num);
		ResultSet result = psmt.executeQuery();
		
		while(result.next()) {
			psmt = connection.prepareStatement("update post set title=?, writer=?, content=? where num=" + num);
			psmt.setString(1, title);
			psmt.setString(2, writer);
			psmt.setString(3, content);
			psmt.executeUpdate();
			response.sendRedirect("post_list.jsp");
		}
	} catch (Exception e){
		out.println("오류가 발생했습니다. 오류 메시지 : " + e.getMessage());
	}
%>