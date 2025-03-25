<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Today's Sales Report</title>
    <link rel="stylesheet" type="text/css" href="css/dailySales.css">
</head>
<body>
    <div class="report-container">
        <h1>Today's Sales Report</h1>
        <table>
            <tr>
                <th>Date</th>
                <th>Total Sales (₹)</th>
                <th>Total Transactions</th>
            </tr>
            <%
                Connection conn = null;
                PreparedStatement stmt = null;
                ResultSet rs = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                    String query = "SELECT * FROM daily_sales WHERE saleDate = CURDATE()";
                    stmt = conn.prepareStatement(query);
                    rs = stmt.executeQuery();

                    if (rs.next()) {
            %>
            <tr>
                <td><%= rs.getDate("saleDate") %></td>
                <td>₹<%= rs.getDouble("totalSales") %></td>
                <td><%= rs.getInt("totalTransactions") %></td>
            </tr>
            <% 
                    } else {
                        out.println("<tr><td colspan='3'>No sales data available for today.</td></tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                }
            %>
        </table>
        <a href="billing.jsp" class="back-btn">Back to Billing</a>
    </div>
</body>
</html>
