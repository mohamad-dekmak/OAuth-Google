<%-- 
    Document   : list
    Created on : Aug 20, 2015, 9:58:11 AM
    Author     : mdekmak
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="m.dekmak.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Google OAuth 2.0 v1</title>
        <style>
            body {
                font-family: Sans-Serif;
                margin: 1em;
            }

            .oauthDemo a {
                display: block;
                border-style: solid;
                border-color: #bbb #888 #666 #aaa;
                border-width: 1px 2px 2px 1px;
                background: #ccc;
                color: #333;
                line-height: 2;
                text-align: center;
                text-decoration: none;
                font-weight: 900;
                width: 25em;
                float: right;
            }

            .oauthDemo pre {
                background: #ccc;
            }

            .oauthDemo a:active {
                border-color: #666 #aaa #bbb #888;
                border-width: 2px 1px 1px 2px;
                color: #000;
            }

            .readme {
                padding: .5em;
                background-color: #F9AD81;
                color: #333;
            }
            .oauthDemo a, table tr td, table th {
                border-style: solid;
                border-color: #bbb #888 #666 #aaa;
                border-width: 1px 2px 2px 1px;
                background: #ccc;
                color: #333;
                line-height: 2;
                text-align: center;
                text-decoration: none;
                font-weight: 900;
                width: 25em;
            }

        </style>
    </head>
    <body>
        <%
            String userProfileName = request.getUserPrincipal().getName();
            out.println("<h3 align='center'>Welcome \"" + userProfileName + "\" to SMB215 - Google Auth API"
                    + "<a href=\"https://localhost:8443/OAuth2v1/logout.jsp\" style=\"float: right;\">Sign Out</a> </h3>");
        %>
        <div class="oauthDemo">
            <a href="../index.jsp" style="float: left;">Home Page</a>
            <br />
            <br />
            <br />
            <br />
            <h3 align="center">Tomcat Users List</h3>
            <br />
            <table>
                <thead>
                <th style="width: 400px;">Username "Local Account"</th>
                    <th style="width: 400px;">User Group "Role"</th>
                    <th style="width: 400px;">Email "Google Account"</th>
                    <th style="width: 400px;">Has Google Authentication</th>
                </thead>
                <tbody>
                    <%
                        List<String> users = new ArrayList<String>();

                        Database db = new Database();
                        users = db.getUsersList();
                    %>

                    <%  for (int i = 0; i < users.size(); i++) {
                            String cell = (String) users.get(i);
                            String[] params = cell.split(",");
                    %>
                    <tr>
                        <%
                            for (int j = 0; j < params.length; j++) {
                                String text = params[j];
                                if (text.startsWith("[")) {
                                    text = text.substring(1);
                                }
                                if (text.endsWith("]")) {
                                    text = text.substring(0, text.length() - 1);
                                }
                        %>
                        <td style="width: 400px;"><%= text%></td>
                        <% }
                        %>
                    </tr>
                    <%
                        }%>

                </tbody>

            </table>
        </div>
    </body>
</html>
