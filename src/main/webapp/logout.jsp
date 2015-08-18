<%-- 
    Document   : logout
    Created on : Aug 18, 2015, 12:08:27 PM
    Author     : mdekmak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <%
        session = request.getSession();
        session.invalidate();
    %>
    <body>
    <center>
        <h1>Logout</h1>
        You have successfully logged out.
        Click <a href="https://localhost:8443/OAuth2v1"><b>here</b></a> for another login.
    </center>
</body>
</html>
