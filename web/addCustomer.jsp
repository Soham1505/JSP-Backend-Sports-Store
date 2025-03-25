<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add New Customer</title>
    <link rel="stylesheet" href="css/addCustomer.css">
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
        <h2>Soham Sports Store - Add New Customer</h2>
    </header>

    <main>
        <%
            String nextCustomerId = "1";
            Connection connection = null;
            PreparedStatement preparedStatement = null;
            ResultSet resultSet = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                String maxIdQuery = "SELECT MAX(customerId) FROM customers";
                preparedStatement = connection.prepareStatement(maxIdQuery);
                resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    int maxId = resultSet.getInt(1);
                    nextCustomerId = String.valueOf(maxId + 1);
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (resultSet != null) resultSet.close();
                    if (preparedStatement != null) preparedStatement.close();
                    if (connection != null) connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>

        <form action="" method="post">
            <label for="customerId">Customer ID:</label>
            <input type="text" id="customerId" name="customerId" value="<%= nextCustomerId %>" >

            <label for="customerName">Customer Name:</label>
            <input type="text" id="customerName" name="customerName" required>

            <label for="customerPhone">Phone Number:</label>
            <input type="tel" id="customerPhone" name="customerPhone" required>

            <label for="customerEmail">Email:</label>
            <input type="email" id="customerEmail" name="customerEmail" required>

            <label for="customerAddress">Address:</label>
            <textarea id="customerAddress" name="customerAddress" rows="4" required></textarea>

            <button type="submit">Submit</button>
        </form>

        <div class="actions">
            <a href="welcome.jsp"><button type="button">Back to Home</button></a>
        </div>

        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String id = request.getParameter("customerId");
                String customerName = request.getParameter("customerName");
                String customerPhone = request.getParameter("customerPhone");
                String customerEmail = request.getParameter("customerEmail");
                String customerAddress = request.getParameter("customerAddress");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/sportsstore", "root", "root");

                    String checkQuery = "SELECT * FROM customers WHERE name = ? OR phone = ? OR email = ?";
                    preparedStatement = connection.prepareStatement(checkQuery);
                    preparedStatement.setString(1, customerName);
                    preparedStatement.setString(2, customerPhone);
                    preparedStatement.setString(3, customerEmail);

                    resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<p class='error'>Error: A customer with the same name, phone number, or email already exists.</p>");
                    } else {
                        String insertQuery = "INSERT INTO customers (id, name, phone, email, adress) VALUES (?, ?, ?, ?, ?)";
                        preparedStatement = connection.prepareStatement(insertQuery);

                        preparedStatement.setString(1, id);
                        preparedStatement.setString(2, customerName);
                        preparedStatement.setString(3, customerPhone);
                        preparedStatement.setString(4, customerEmail);
                        preparedStatement.setString(5, customerAddress);

                        int rowsInserted = preparedStatement.executeUpdate();

                        if (rowsInserted > 0) {
                            out.println("<p class='success'>Customer added successfully! Customer ID: " + id + "</p>");
                        } else {
                            out.println("<p class='error'>Failed to add customer. Please try again.</p>");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (preparedStatement != null) preparedStatement.close();
                        if (connection != null) connection.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </main>

    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>
</body>
</html>
