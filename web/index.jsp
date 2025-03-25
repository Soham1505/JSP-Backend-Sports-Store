<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="index.css"> 
  <style>
    .error-message {
      color: red;
      font-weight: bold;
      margin-top: 10px;
    }
  </style>
</head>
<body>

  <header>
    SOHAM SPORTS STORE , KALAMBOLI
  </header>

 
  <div class="form-container">
    <h1>Login</h1>
    <form action="login.jsp" method="post">
      <div class="form-group">
        <label for="username">Username</label>
        <input type="text" id="username" name="username" placeholder="Enter your username" required >
      </div>
      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Enter your password" required>
      </div>
      <button type="submit" class="btn">Login</button>

      
    </form>

    <% 

      String error = (String) request.getAttribute("error");
      if (error != null && !error.trim().isEmpty()) {
    %>
      <div class="error-message"><%= error %></div>
    <% 
      }
    %>
  </div>


  <footer>
    <p><h3>Developer: Soham Ingawale, Copyright 2025</h3></p>
  </footer>

</body>
</html>
