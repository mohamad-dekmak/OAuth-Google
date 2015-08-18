<%-- 
    Document   : login
    Created on : Aug 18, 2015, 11:25:27 AM
    Author     : mdekmak
--%>

<%@page import="m.dekmak.GoogleAuth"%>
<%@page import="m.dekmak.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Form</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            body {
                font-family: Sans-Serif;
                margin: 1em;
            }

            .oauthDemo a, table tr td {
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
            div.centre
            {
                width: 407px;
                display: block;
                margin-left: auto;
                margin-right: auto;
            }
        </style>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div class="centre">
            <form method="POST" action="j_security_check" id="loginForm">
                <table>
                    <tr>
                        <td colspan="2">Login to the SMB215 application:</td>
                    </tr>
                    <tr>
                        <td>Username:  <input type="text" name="j_username" id="username" /></td>
                    </tr>
                    <tr>
                        <td>Password:  <input type="password" name="j_password" id="password" /></td>
                    </tr>
                    <tr>
                        <td colspan="2"><input type="submit" value="Login" /></td>
                    </tr>
                </table>
            </form>
            <br />
            OR
            <br />
            <br />
            <div class="oauthDemo">
                <%!
                    String userInfo, userEmail, userId;
                %>
                <%
                    /*
                     * The GoogleAuth handles all the heavy lifting, and contains all "secrets"
                     * required for constructing a google login url.
                     */
                    final GoogleAuth helper = new GoogleAuth();

                    out.println("<a href='" + helper.buildLoginUrl()
                            + "'>Login with Google Account</a>");

                    if (request.getParameter("code") != null && request.getParameter("state") != null) {

                        /*
                         * Executes after google redirects to the callback url.
                         * Please note that the state request parameter is for convenience to differentiate
                         * between authentication methods (ex. facebook oauth, google oauth, twitter, in-house).
                         * 
                         * GoogleAuth()#getUserInfoJson(String) method returns a String containing
                         * the json representation of the authenticated user's information. 
                         * At this point you should parse and persist the info.
                         */
                        userInfo = helper.getUserInfoJson(request.getParameter("code"));
                        userEmail = helper.getParameterFromUserInfo(userInfo, "email");
                        userId = helper.getParameterFromUserInfo(userInfo, "id");
                        Database db = new Database();
                        String[] ret = db.getUserCredentials(userEmail, userId);
                        String username = "";
                        String pass = "";
                        int index = 0;
                        for (String key : ret) {
                            if (ret.length > 1) {
                                index++;
                                if (index == 1) {
                                    username = key;
                                } else if (index == 2) {
                                    pass = key;
                                }
                            } else { // exception msg
                                out.println(key);
                            }
                        }
                        if (username != "" && pass != "") {
                            // to avoid the conflict between the request from login form and the request from inside the application
                            session.setAttribute("isRedirectedFormLoginForm", "1");
                %>
                <script language="javascript">
                    var userName = "<%= username%>";
                    var password = "<%= pass%>";
                    document.getElementById("username").value = userName;
                    document.getElementById("password").value = password;
                    document.getElementById("loginForm").submit();
                </script>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
