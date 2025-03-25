<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Generate Bill</title>
    <link rel="stylesheet" type="text/css" href="css/generateBill.css">
</head>
<body>
    <div class="bill-container">
        <h1>Soham Sports Store, Kalamboli</h1>

        <%
            String customerId = request.getParameter("customerId");
            String productId = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            Connection conn = null;
            PreparedStatement customerStmt = null, productStmt = null, insertStmt = null, dailyStmt = null;
            ResultSet customerRs = null, productRs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                customerStmt = conn.prepareStatement("SELECT name, email, phone FROM customers WHERE id = ?");
                customerStmt.setString(1, customerId);
                customerRs = customerStmt.executeQuery();

                productStmt = conn.prepareStatement("SELECT productName, price FROM products WHERE productId = ?");
                productStmt.setString(1, productId);
                productRs = productStmt.executeQuery();

                if (customerRs.next() && productRs.next()) {
                    String customerName = customerRs.getString("name");
                    String email = customerRs.getString("email");
                    String phone = customerRs.getString("phone");

                    String productName = productRs.getString("productName");
                    double price = productRs.getDouble("price");
                    int quantity = Integer.parseInt(quantityStr);
                    double totalAmount = price * quantity;

                    insertStmt = conn.prepareStatement("INSERT INTO billing (customerId, productId, quantity, totalAmount, date) VALUES (?, ?, ?, ?, NOW())");
                    insertStmt.setInt(1, Integer.parseInt(customerId));
                    insertStmt.setInt(2, Integer.parseInt(productId));
                    insertStmt.setInt(3, quantity);
                    insertStmt.setDouble(4, totalAmount);
                    int rowsInserted = insertStmt.executeUpdate();

                    dailyStmt = conn.prepareStatement("INSERT INTO daily_sales (saleDate, totalSales, totalTransactions) VALUES (CURDATE(), ?, 1) ON DUPLICATE KEY UPDATE totalSales = totalSales + ?, totalTransactions = totalTransactions + 1");
                    dailyStmt.setDouble(1, totalAmount);
                    dailyStmt.setDouble(2, totalAmount);
                    dailyStmt.executeUpdate();
        %>

        <h2>Customer Details</h2>
        <table>
            <tr><th>Name</th><td><%= customerName %></td></tr>
            <tr><th>Email</th><td><%= email %></td></tr>
            <tr><th>Phone</th><td><%= phone %></td></tr>
        </table>

        <h2>Product Details</h2>
        <table>
            <tr><th>Product Name</th><td><%= productName %></td></tr>
            <tr><th>Price</th><td>₹<%= price %></td></tr>
            <tr><th>Quantity</th><td><%= quantity %></td></tr>
            <tr><th>Total Cost</th><td>₹<%= totalAmount %></td></tr>
        </table>

        <div class="total">Grand Total: ₹<%= totalAmount %></div>

        <%
                    if (rowsInserted <= 0) {
                        out.println("<p>Error: Failed to generate bill.</p>");
                    }
                } else {
                    out.println("<p>Error: Customer or product details not found.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error occurred while generating the bill.</p>");
            } finally {
                try {
                    if (customerRs != null) customerRs.close();
                    if (productRs != null) productRs.close();
                    if (customerStmt != null) customerStmt.close();
                    if (productStmt != null) productStmt.close();
                    if (insertStmt != null) insertStmt.close();
                    if (dailyStmt != null) dailyStmt.close();
                    if (conn != null) conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>

        <div class="button-container">
            <a href="billing.jsp" class="btn">Back to Billing</a>
            <a href="welcome.jsp" class="btn">Home</a>
            <a href="#" class="btn" onclick="window.print()">Print Bill</a>
        </div>
    </div>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>
</html>
