<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Billing History</title>
    <link rel="stylesheet" type="text/css" href="css/billingHistory.css">
</head>
<body>
    <h1>Billing History</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Customer Name</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Total Amount</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");
                    String query = "SELECT b.id, c.name AS customerName, p.productName, b.quantity, b.totalAmount, b.date " +
                                   "FROM billing b " +
                                   "JOIN customers c ON b.customerId = c.id " +
                                   "JOIN products p ON b.productId = p.productId";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("customerName") %></td>
                <td><%= rs.getString("productName") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td>₹<%= rs.getDouble("totalAmount") %></td>
                <td><%= rs.getTimestamp("date") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>

    <% 
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    } %>
</body>
</html>
