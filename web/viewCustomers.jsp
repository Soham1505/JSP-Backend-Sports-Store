<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Customers</title>
    <link rel="stylesheet" type="text/css" href="css/viewCustomer.css">
</head>
<body>
    <header>
        <h1>View Customers</h1>
    </header>

    <main>
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                stmt = conn.prepareStatement("SELECT * FROM customers");
                rs = stmt.executeQuery();
        %>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Address</th>
            </tr>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("phone") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("adress") %></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </main>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>
</html>
