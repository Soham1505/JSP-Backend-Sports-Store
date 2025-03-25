<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Product</title>
    <link rel="stylesheet" type="text/css" href="css/deleteProduct.css">
</head>
<body>
    <header>
        <h1>Hello, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Guest" %></h1>
        <h1>Delete Product</h1>
    </header>

    <form action="" method="post">
        <label for="searchId">Enter Product ID to Search:</label>
        <input type="text" id="searchId" name="searchId" value="<%= request.getParameter("searchId") != null ? request.getParameter("searchId") : "" %>" required>
        <button type="submit">Search Product</button>
    </form>

    <%
        String searchId = request.getParameter("searchId");
        if (searchId != null && !searchId.isEmpty()) {
            try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                 PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM products WHERE productId = ?")) {

                preparedStatement.setString(1, searchId);
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
    %>

    <form action="" method="post">
        <input type="hidden" name="productId" value="<%= searchId %>">
        <label>Product Name:</label>
        <input type="text" value="<%= resultSet.getString("productName") %>" readonly>

        <label>Price:</label>
        <input type="text" value="?<%= String.format("%.2f", resultSet.getDouble("price")) %>" readonly>

        <label>Description:</label>
        <textarea rows="4" readonly><%= resultSet.getString("description") %></textarea>

        <button type="submit" name="delete" value="delete">Delete Product</button>
    </form>

    <%
                } else {
                    out.println("<p style='color:red;'>No product found with that ID.</p>");
                }
                resultSet.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }

        if ("delete".equals(request.getParameter("delete"))) {
            String productId = request.getParameter("productId");

            if (productId != null && !productId.isEmpty()) {
                try (Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                     PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM products WHERE productId = ?")) {

                    preparedStatement.setString(1, productId);
                    int rowsAffected = preparedStatement.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p style='color:green;'>Product deleted successfully.</p>");
                    } else {
                        out.println("<p style='color:red;'>Error: Could not delete the product. Please try again.</p>");
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                }
            }
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
