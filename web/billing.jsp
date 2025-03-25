<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing Page</title>
    <link rel="stylesheet" type="text/css" href="css/billing.css">
</head>
<body>
    <h1>Billing Page</h1>

    <%
        Connection conn = null;
        PreparedStatement customerStmt = null, productStmt = null;
        ResultSet customerRs = null, productRs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

            customerStmt = conn.prepareStatement("SELECT id, name FROM customers");
            customerRs = customerStmt.executeQuery();

            productStmt = conn.prepareStatement("SELECT productId, productName, price FROM products");
            productRs = productStmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <form action="generateBill.jsp" method="post">
        <label for="customerId">Select Customer:</label>
        <select id="customerId" name="customerId" required>
            <option value="">-- Select Customer --</option>
            <% while (customerRs.next()) { %>
                <option value="<%= customerRs.getInt("id") %>"><%= customerRs.getString("name") %></option>
            <% } %>
        </select>

        <label for="productId">Select Product:</label>
        <select id="productId" name="productId" required>
            <option value="">-- Select Product --</option>
            <% while (productRs.next()) { %>
                <option value="<%= productRs.getInt("productId") %>" data-price="<%= productRs.getDouble("price") %>">
                    <%= productRs.getString("productName") %> - ₹<%= productRs.getDouble("price") %>
                </option>
            <% } %>
        </select>

        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" min="1" required>

        <div class="total">Total Cost: ₹<span id="totalCost">0.00</span></div>

        <button type="submit">Generate Bill</button>
    </form>
    
    <button class="btn-secondary" onclick="location.href='welcome.jsp'">Home Page</button>

    <script>
        document.getElementById("productId").addEventListener("change", calculateTotal);
        document.getElementById("quantity").addEventListener("input", calculateTotal);

        function calculateTotal() {
            const product = document.getElementById("productId").selectedOptions[0];
            const price = parseFloat(product.getAttribute("data-price")) || 0;
            const quantity = parseInt(document.getElementById("quantity").value) || 0;
            document.getElementById("totalCost").textContent = (price * quantity).toFixed(2);
        }
    </script>

    <%
        if (customerRs != null) customerRs.close();
        if (productRs != null) productRs.close();
        if (customerStmt != null) customerStmt.close();
        if (productStmt != null) productStmt.close();
        if (conn != null) conn.close();
    %>
</body>
</html>
