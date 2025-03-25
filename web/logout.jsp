<%@ page session="true" %>
<%@ page import="java.io.*" %>

<%
    // Invalidate the session to log out the user
    session.invalidate();

    // Redirect to the login page
    response.sendRedirect("login.jsp");
%>
