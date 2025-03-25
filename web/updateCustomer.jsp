<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Customer</title>
    <link rel="stylesheet" type="text/css" href="css/updateCustomer.css">
</head>
<body>

    <header>
        <% 
            String username = (String) session.getAttribute("username"); 
            if (username == null) {
                username = "Guest";
            }
        %>
        <h1>Welcome, <%= username %></h1>
        <h2>Update Customer Details</h2>
    </header>

    <form action="" method="post">
        <label for="customerId">Enter Customer ID:</label>
        <input type="text" id="customerId" name="customerId" required>
        <button type="submit" name="search">Search</button>
    </form>

    <%
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        String customerId = request.getParameter("customerId");

        if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("search") != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                String searchQuery = "SELECT * FROM customers WHERE id = ?";
                preparedStatement = connection.prepareStatement(searchQuery);
                preparedStatement.setString(1, customerId);
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
    %>

    <form action="" method="post">
        <input type="hidden" name="customerId" value="<%= customerId %>">

        <label for="customerName">Name:</label>
        <input type="text" id="customerName" name="customerName" value="<%= resultSet.getString("name") %>" required>

        <label for="customerEmail">Email:</label>
        <input type="email" id="customerEmail" name="customerEmail" value="<%= resultSet.getString("email") %>" required>

        <label for="customerAddress">Address:</label>
        <textarea id="customerAddress" name="customerAddress" rows="3" required><%= resultSet.getString("adress") %></textarea>

        <label for="customerPhone">Phone:</label>
        <input type="tel" id="customerPhone" name="customerPhone" value="<%= resultSet.getString("phone") %>" required>

        <button type="submit" name="update">Update</button>
    </form>

    <%
                } else {
                    out.println("<p style='color: red;'>Customer not found.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            }
        }

        if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("update") != null) {
            String updatedName = request.getParameter("customerName");
            String updatedEmail = request.getParameter("customerEmail");
            String updatedAddress = request.getParameter("customerAddress");
            String updatedPhone = request.getParameter("customerPhone");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                String updateQuery = "UPDATE customers SET name = ?, email = ?, adress = ?, phone = ? WHERE id = ?";
                preparedStatement = connection.prepareStatement(updateQuery);
                preparedStatement.setString(1, updatedName);
                preparedStatement.setString(2, updatedEmail);
                preparedStatement.setString(3, updatedAddress);
                preparedStatement.setString(4, updatedPhone);
                preparedStatement.setString(5, customerId);

                int rowsUpdated = preparedStatement.executeUpdate();

                if (rowsUpdated > 0) {
                    out.println("<p style='color: green;'>Customer updated successfully!</p>");
                } else {
                    out.println("<p style='color: red;'>Update failed. Try again.</p>");
                }
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error: " + e.getMessage() + "</p>");
            } finally {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
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
