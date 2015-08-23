<%-- 
    Document   : login-failed
    Created on : Aug 23, 2015, 10:36:27 AM
    Author     : mdekmak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SMB215 - Google Auth API</title>
        <link type="text/css" rel="stylesheet" href="resources/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="resources/css/bootstrap-theme.min.css">
        <link type="text/css" rel="stylesheet" href="resources/css/main.css">
        <script src="resources/js/jquery-1.11.3.min.js" type="text/javascript"></script>
        <script src="resources/js/bootstrap.min.js" type="text/javascript"></script>
    </head>
    <body>
        <div class="container master-container">
            <div class="container">
                <div class="col-md-2"></div>
                <div class="col-md-8 alert alert-info fade in text-center" data-alert="alert">
                    <h4>
                        <strong>
                            Login to access SMB215 Web Application
                        </strong>
                    </h4>
                    <p>Here you'll see the usage of Simple Form or Login with your Google account</p>
                </div><div class="col-md-2"></div>

            </div>
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="panel panel-primary">
                        <div class="panel-heading">User credentials are incorrect</div>
                        <div class="panel-body">
                            <a class="btn btn-default" href="javascript:;" onclick="window.history.back();">Retry again</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </body>
</html>

