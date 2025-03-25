<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <link rel="stylesheet" href="css/welcome.css">
</head>
<body>
    
    <header class="navbar">
        <a href="home.jsp">Home</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a>

        <div class="welcome-message">
            <% String username = (String) session.getAttribute("username"); %>
            <span>Welcome, <%= (username != null) ? username : "Guest" %>!</span>
        </div>

        <form action="logout.jsp" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </header>

    <main class="content">
        <h1>Welcome to Soham Sports Store!</h1>
        <p>Find the best sports products at great prices.</p>

        <div class="btn-container">
            <button onclick="location.href='addCustomer.jsp'">Add Customer</button>
            <button onclick="location.href='updateCustomer.jsp'">Update Customer</button>
            <button onclick="location.href='viewCustomers.jsp'">View Customers</button>
            <button onclick="location.href='deleteCustomer.jsp'">Delete Customer</button>
            <button onclick="location.href='addProduct.jsp'">Add Product</button>
            <button onclick="location.href='updateProduct.jsp'">Update Product</button>
            <button onclick="location.href='viewProducts.jsp'">View Products</button>
            <button onclick="location.href='deleteProduct.jsp'">Delete Product</button>
            <button onclick="location.href='billing.jsp'">Billing</button>
        </div>

        <section class="contact-info">
            <h2>Contact Us</h2>
            <p><strong>Email:</strong> kalambolisportssupport@gmail.com</p>
            <p><strong>Phone:</strong> 742580000</p>
            <p><strong>Address:</strong> Sector 1 E, Plot No: 29, Kalamboli, Navi Mumbai - 41028</p>
        </section>
    </main>

  
    <footer>
        <p>Developer: Soham Ingawale &copy; 2025</p>
    </footer>

</body>
</html>
