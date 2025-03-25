<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="database1.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Login Status</title>
</head>
<body>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        

        conn = DBConnection.getConnection();
        if (conn == null) {
            throw new Exception("Database connection is null!");
        }

        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, username);
        stmt.setString(2, password);

        rs = stmt.executeQuery();

        if (rs.next()) {
          
            HttpSession session1 = request.getSession();
            session1.setAttribute("username", username);
            response.sendRedirect("welcome.jsp");
        } else {
           
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("error", "Database error occurred");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "An error occurred");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    } finally {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
