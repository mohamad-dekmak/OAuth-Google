<%@page import="m.dekmak.GoogleAuth"%>
<%@page import="m.dekmak.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

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
        </style>
    </head>
    <body>
        <%
            String userProfileName = request.getUserPrincipal().getName();
            out.println("<h3 align='center'>Welcome \"" + userProfileName + "\" to SMB215 - Google Auth API"
                    + "<a href=\"https://localhost:8443/OAuth2v1/logout.jsp\" style=\"float: right;\">Sign Out</a> </h3>");
        %>
        <div class="oauthDemo">
            <a href="users/list.jsp" style="float: left;">Manage Users</a>
            <%!
                String userInfo, userEmail, userId;
            %>
            <%
                /*
                 * The GoogleAuth handles all the heavy lifting, and contains all "secrets"
                 * required for constructing a google login url.
                 */
                final GoogleAuth helper = new GoogleAuth();
                /*
                 * initial visit to the page
                 */
                out.println("<a href='" + helper.buildLoginUrl()
                        + "'>Authenticate with google for next login</a>");
                if (request.getParameter("code") != null && request.getParameter("state") != null && session.getAttribute("isRedirectedFormLoginForm") == null) {
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
                    out.println("<br />");
                    out.println("<br />");
                    out.println("<br />");
                    out.println(db.updateUserInfo(request.getUserPrincipal().getName(), userEmail, userId));
                }
                if(session.getAttribute("isRedirectedFormLoginForm") != null){
                   session.setAttribute("isRedirectedFormLoginForm", null);
                }
            %>
        </div>
        <br />
        <br />
        <br />
        <div class="readme">
            <h2>Read Me First</h2>

            <h3>Assumptions</h3>

            <ul>
                <li>familiarity with OOP, java, maven, and jee</li>
                <li>java application server listening on localhost:8081</li>
            </ul>

            <h3>Prerequisites</h3>

            <ul>
                <li>Google API access credentials (Client ID, Client Secret).
                    Set it up here <a href='https://code.google.com/apis/console/'>https://code.google.com/apis/console/</a>
                </li>
                <li>Set up allowed Redirect URIs at Google API &rarr; API
                    Access. Input: http://localhost:8081/OAuth2v1/index.jsp</li>
            </ul>

            <h3>Usage</h3>

            <ol>
                <li>Add Client ID, and Client Secret parameters to <b>GoogleAuth.java</b></li>
                <li>Compile the project (<b>$ mvn clean install</b>)</li>
                <li>Deploy war to application server</li>
                <li>Browse to: <a href="http://localhost:8081/OAuth2v1/">http://localhost:8081/OAuth2v1/</a></li>
                <li>Click <b>&quot;Authenticate with google for next login&quot;</b> on top of this page</li>
            </ol>

        </div>
    </body>
</html>
