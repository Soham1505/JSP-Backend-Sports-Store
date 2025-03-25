<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="database1.DBConnection" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
</head>
<body>
    <h2>Registration Status</h2>

    <%
        // Get username and password from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
           
            System.out.println("Received username: " + username);

         
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new Exception("Database connection is null!");
            }
            System.out.println("Database connection established.");

            
            String checkQuery = "SELECT * FROM users WHERE username = ?";
            stmt = conn.prepareStatement(checkQuery);
            stmt.setString(1, username);
            rs = stmt.executeQuery();

            if (rs.next()) {
                out.println("<p style='color:red;'>Username already exists! Try another one.</p>");%>
                    <a href="register.html">Back to Register with another Usrname</a><%
            } else {
           
                String insertQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
                stmt = conn.prepareStatement(insertQuery);
                stmt.setString(1, username);
                stmt.setString(2, password);
                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<p style='color:green;'>Registration successful!</p>");%>
                    <a href="login.jsp">Back to Login</a>
                    <%
                } else {
                    out.println("<p style='color:red;'>Error: Registration failed. Please try again.</p>");
                }
            }
        } catch (SQLException e) {
            out.println("<p style='color:red;'>SQL Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
           
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
                System.out.println("Database resources closed.");
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
                e.printStackTrace();
            }
        }
    %>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>
</html>
