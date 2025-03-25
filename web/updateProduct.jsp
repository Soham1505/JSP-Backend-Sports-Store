<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Product</title>
    <link rel="stylesheet" type="text/css" href="css/updateProduct.css">
</head>
<body>
    <header>
        <h1>Update Product</h1>
    </header>

    <form action="" method="post">
        <label for="productId">Product ID:</label>
        <input type="text" id="productId" name="productId" required>
        <button type="submit" name="search">Search Product</button>
    </form>

    <%
        String productId = request.getParameter("productId");
        String productName = "";
        double productPrice = 0.0;
        String productDescription = "";

        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("search") != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM products WHERE productId = ?")) {

                stmt.setString(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        productName = rs.getString("productName");
                        productPrice = rs.getDouble("price");
                        productDescription = rs.getString("description");
                    } else {
                        out.println("<p style='color:red;'>Error: Product with this ID does not exist.</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        }

        if (!productName.isEmpty()) {
    %>

    <form action="" method="post">
        <input type="hidden" name="productId" value="<%= productId %>">

        <label>Product Name:</label>
        <input type="text" name="productName" value="<%= productName %>" required>

        <label>Product Price:</label>
        <input type="number" name="productPrice" value="<%= productPrice %>" step="0.01" required>

        <label>Product Description:</label>
        <textarea name="productDescription" rows="4" required><%= productDescription %></textarea>

        <button type="submit" name="update">Update Product</button>
    </form>

    <% } %>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("update") != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                 PreparedStatement stmt = conn.prepareStatement("UPDATE products SET productName = ?, price = ?, description = ? WHERE productId = ?")) {

                stmt.setString(1, request.getParameter("productName"));
                stmt.setDouble(2, Double.parseDouble(request.getParameter("productPrice")));
                stmt.setString(3, request.getParameter("productDescription"));
                stmt.setString(4, request.getParameter("productId"));

                int rowsUpdated = stmt.executeUpdate();
                out.println(rowsUpdated > 0 ? "<p style='color:green;'>Product updated successfully!</p>" : "<p style='color:red;'>Failed to update product.</p>");
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
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
