<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Customer</title>
    <link rel="stylesheet" type="text/css" href="css/deleteCustomer.css">
</head>
<body>
    <header>
        <h1>Delete Customer</h1>
    </header>

    <main>
        <form action="" method="post">
            <label>Enter Customer ID:</label>
            <input type="text" name="searchId" required>
            <button type="submit">Search</button>
        </form>

        <%
            String searchId = request.getParameter("searchId");
            if (searchId != null && !searchId.isEmpty()) {
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                    stmt = conn.prepareStatement("SELECT * FROM customers WHERE id = ?");
                    stmt.setString(1, searchId);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
        %>
        <form action="" method="post">
            <input type="hidden" name="deleteId" value="<%= rs.getString("id") %>">
            
            <p><strong>Name:</strong> <%= rs.getString("name") %></p>
            <p><strong>Email:</strong> <%= rs.getString("email") %></p>
            <p><strong>Address:</strong> <%= rs.getString("adress") %></p>
            
            <button type="submit" name="delete">Delete Customer</button>
        </form>
        <%
                    } else {
                        out.println("<p>No customer found.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            }

            if (request.getParameter("delete") != null) {
                String deleteId = request.getParameter("deleteId");

                if (deleteId != null && !deleteId.isEmpty()) {
                    Connection conn = null;
                    PreparedStatement stmt = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                    
                        stmt = conn.prepareStatement("DELETE FROM billing WHERE customerId = ?");
                        stmt.setString(1, deleteId);
                        stmt.executeUpdate();
                        stmt.close();

                      
                        stmt = conn.prepareStatement("DELETE FROM customers WHERE id = ?");
                        stmt.setString(1, deleteId);
                        int result = stmt.executeUpdate();

                        if (result > 0) {
                            out.println("<p style='color:green;'>Customer and associated billing records deleted.</p>");
                        } else {
                            out.println("<p style='color:red;'>Deletion failed.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    }
                }
            }
        %>
    </main>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>  
</html>  
