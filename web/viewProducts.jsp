<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View All Products</title>
    <link rel="stylesheet" type="text/css" href="css/viewProducts.css">
</head>
<body>
    <header>
        <h1>Hello, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></h1>
        <h1>View All Products</h1>
    </header>

    <%
        try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
             PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM products");
             ResultSet resultSet = preparedStatement.executeQuery()) {

            if (!resultSet.isBeforeFirst()) {
                out.println("<p>No products found.</p>");
            } else {
    %>

    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
                while (resultSet.next()) {
            %>
            <tr>
                <td><%= resultSet.getInt("productId") %></td>
                <td><%= resultSet.getString("productName") %></td>
                <td>?<%= String.format("%.2f", resultSet.getDouble("price")) %></td>
                <td><%= resultSet.getString("description") %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    %>

    <div class="actions">
        <a href="welcome.jsp"><button type="button">Back to Home</button></a>
    </div>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>
</html>
