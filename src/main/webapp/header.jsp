<%-- 
    Document   : header
    Created on : Aug 20, 2015, 06:16:14 PM
    Author     : mdekmak
--%>

<%@page import="m.dekmak.GoogleAuth"%>
<%@page import="m.dekmak.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SMB215 - Google Auth API</title>
        <link type="text/css" rel="stylesheet" href="resources/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="resources/css/bootstrap-theme.min.css">
        <link type="text/css" rel="stylesheet" href="resources/css/bootstrap-select.min.css">
        <link type="text/css" rel="stylesheet" href="resources/css/main.css">
        <script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="resources/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="resources/js/bootstrap-select.min.js" type="text/javascript"></script>
        <script src="resources/js/general.js" type="text/javascript"></script>
    </head>
    <body>
        <%
            final GoogleAuth helper = new GoogleAuth();
            String userProfileName = request.getUserPrincipal().getName();
        %>
        <div class="container">
            <div class="col-md-2"></div>
            <div class="col-md-8 alert alert-info fade in text-center" data-alert="alert">
                <h4>
                    <strong>
                        Welcome "<% out.println(userProfileName); %>" to SMB215 - Google Auth API
                    </strong>
                </h4>
                <p>Here you'll see the features and full pages of SMB215</p>
            </div><div class="col-md-2"></div>

        </div>
        <nav id="navbar-example" class="navbar navbar-default navbar-static">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".bs-example-js-navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="index.jsp">SMB215</a>
                </div>
                <div class="collapse navbar-collapse bs-example-js-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Manage Users
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="drop1">
                                <li><a href="users-list.jsp">Users List</a></li>
                                <li class="divider"></li>
                                <li><a href="user-add.jsp">Add User</a></li>
                            </ul>
                        </li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li id="fat-menu" class="dropdown">
                            <a id="drop3" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                <%
                                    out.println(userProfileName);
                                %>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="drop3">
                                <li><a href="user-profile-change-pwd.jsp">Change Password</a></li>
                                <li> <%
                                    out.println("<a href='" + helper.buildLoginUrl() + "'>Authenticate with Google for next login</a>");
                                    %>
                                </li>
                                <li><a href="users-list.jsp">Users List</a></li>
                                <li class="divider"></li>
                                <li><a href="https://github.com/pascalfares/smb215-15" target="_blank">Help</a></li>
                                <li><a href="#" id="aboutLink">About</a></li>
                                <li><a href="https://github.com/pascalfares/smb215-15/issues" target="_blank">Report a bug</a></li>
                                <li class="divider"></li>
                                <li><a href="https://localhost:8443/SMB215-OAuth-Google/logout.jsp">Sign out</a></li>
                            </ul>
                        </li>
                    </ul>
                </div><!-- /.nav-collapse -->
            </div><!-- /.container-fluid -->
        </nav>