<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Product</title>
    <link rel="stylesheet" type="text/css" href="css/addProduct.css">
</head>
<body>
    <header>
        <h1>Add New Product</h1>
    </header>

    <%
        String nextProductId = "1"; 
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
             PreparedStatement stmt = conn.prepareStatement("SELECT MAX(productId) FROM products");
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                int maxId = rs.getInt(1);
                nextProductId = String.valueOf(maxId + 1);
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    %>

    <form action="" method="post">
        <label>Product ID:</label>
        <input type="text" name="productId" value="<%= nextProductId %>" readonly>

        <label>Product Name:</label>
        <input type="text" name="productName" required>

        <label>Price:</label>
        <input type="number" name="productPrice" step="0.01" required>

        <label>Description:</label>
        <textarea name="productDescription" rows="4" required></textarea>

        <button type="submit" name="addProduct">Add Product</button>
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("addProduct") != null) {
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                 PreparedStatement stmt = conn.prepareStatement("INSERT INTO products (productId, productName, price, description) VALUES (?, ?, ?, ?)")) {

                stmt.setString(1, request.getParameter("productId"));
                stmt.setString(2, request.getParameter("productName"));
                stmt.setDouble(3, Double.parseDouble(request.getParameter("productPrice")));
                stmt.setString(4, request.getParameter("productDescription"));

                int rows = stmt.executeUpdate();
                out.println(rows > 0 ? "<p style='color:green;'>Product added successfully!</p>" : "<p style='color:red;'>Failed to add product.</p>");
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
