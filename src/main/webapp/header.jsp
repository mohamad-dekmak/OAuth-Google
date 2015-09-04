<%-- 
    Document   : header
    Created on : Aug 20, 2015, 06:16:14 PM
    Author     : mdekmak
--%>

<%@page import="m.dekmak.GoogleAuth"%>
<%@page import="m.dekmak.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="m.dekmak.ConfigProperties"%>
<%
    ConfigProperties confProp = new ConfigProperties();
    String appName = confProp.getPropValue("appName");
    String appVersion = confProp.getPropValue("appVersion");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= appName%></title>
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
        <script type="text/javascript">
            $(document).ready(function () {
                // get counter nb of pending notifications
                setTimeout(function(){
                    getCounterNotifications('<%= request.getUserPrincipal().getName()%>'); 
                }, 1000); // Display the counter nb after 1 second (1000 millisecond):
                $('[data-toggle="popover"]').popover({
                    placement: 'bottom'
                }).click(function (e) {
                    if ($('.popover').hasClass('in')) {
                        // popover is visible
                        getPendingNotifications('<%= request.getUserPrincipal().getName()%>', $('.popover-content'));
                    }
                });
            });
        </script>
        <div class="hide" id="notification-content-template">
            <div>
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <img class="loading-image" src="resources/images/icons/loading.png" />
                </div>
                <div class="col-md-4"></div>
                <a href="notify.jsp" class="btn btn-link">Notify</a>
                <a href="show-my-notifications.jsp" class="btn btn-link pull-right">Show all</a>
            </div>
        </div>
        <%
            String userProfileName = request.getUserPrincipal().getName();
        %>
        <div class="container">
            <div class="col-md-2"></div>
            <div class="col-md-8 alert alert-info fade in text-center" data-alert="alert">
                <h4>
                    <strong>
                        Welcome "<%= userProfileName%>" to <%= appName%>
                    </strong>
                </h4>
                <p>Here you'll see the features and full pages of <%= appName%></p>
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
                    <a class="navbar-brand" href="index.jsp"><%= appName%></a>
                </div>
                <div class="collapse navbar-collapse bs-example-js-navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li class="dropdown">
                            <a id="dropDashboard" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Dashboard
                            </a>
                        </li>
                        <li class="dropdown">
                            <a id="dropContact" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Contact
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="dropContact">
                                <li><a href="#">Contact</a></li>
                                <li class="divider"></li>
                                <li><a href="contact-add.jsp">Add Contact</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a id="dropTask" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Task
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="dropTask">
                                <li><a href="#">My Tasks</a></li>
                                <li class="divider"></li>
                                <li><a href="#">All Tasks</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a id="dropCal" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Calendar
                            </a>
                        </li>
                        <li class="dropdown">
                            <a id="dropStock" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Stock
                            </a>
                        </li>
                        <li class="dropdown">
                            <a id="dropAcc" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Accounting
                            </a>
                        </li>
                        <li class="dropdown">
                            <a id="dropReports" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button">
                                Reports
                            </a>
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
                                <li class="divider"></li>
                                <li>
                                    <a href="#" class="header-change-pwd">Change Language</a>
                                </li>
                                <li><a href="#">English</a></li>
                                <li><a href="#">Arabic</a></li>
                                <li><a href="#">Français</a></li>
                                <li class="divider"></li>
                                <li><a href="social-networks.jsp">Social Networks</a></li>
                                <li><a href="admin-setup.jsp">Administration & Setup</a></li>
                                <li class="divider"></li>
                                <li><a href="https://github.com/pascalfares/smb215-15" target="_blank">Help</a></li>
                                <li><a href="#" onclick="aboutApp('<%= appName%>', '<%= appVersion%>');">About</a></li>
                                <li><a href="https://github.com/pascalfares/smb215-15/issues" target="_blank">Report a bug</a></li>
                                <li class="divider"></li>
                                <li><a href="https://localhost:8443/SMB215-OAuth-Google/logout.jsp">Sign out</a></li>
                            </ul>
                        </li>
                    </ul>
                    <button type="button" class="btn btn-default pull-right" style="margin-top: 10px;" data-toggle="popover" title="Notifications" data-content="" id="notificationBtn">
                        <span class="glyphicon glyphicon-flag" aria-hidden="true" id="notificationSpan"></span>
                    </button>
                </div><!-- /.nav-collapse -->
            </div><!-- /.container-fluid -->
        </nav>