<%@include file="header.jsp" %>

<script type="text/javascript">
$(function(){
    // to remove the conflict in the Google GET Params between the "login action in login form" and "authenticate action in home page" 
   clearGoogleParamsFromURL();
});
</script>
<div class="page-container">
    <%!
        String userInfo, userEmail, userId;
    %>
    <%
        /*
         * The GoogleAuth handles all the heavy lifting, and contains all "secrets"
         * required for constructing a google login url.
         */
        /*
         * initial visit to the page
         */
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
            out.println("<div class='panel panel-success'>");
            out.println("<div class='panel-heading'>Authentication Response</div>");
            out.println("<div class='panel-body'>");
            out.println(db.updateUserInfo(request.getUserPrincipal().getName(), userEmail, userId));
            out.println("</div>");
            out.println("</div>");
        }
        if (session.getAttribute("isRedirectedFormLoginForm") != null) {
            session.setAttribute("isRedirectedFormLoginForm", null);
        }
    %>
</div>
<div class="panel panel-info">
    <div class="panel-heading">Read Me First</div>
    <div class="panel-body">
        <div class="readme">
            <h4>Assumptions</h4>
            <ul>
                <li>familiarity with OOP, java, maven, and jee</li>
                <li>java application server listening on localhost:8081</li>
            </ul>
            <h4>Prerequisites</h4>
            <ul>
                <li>Google API access credentials (Client ID, Client Secret).
                    Set it up here <a href='https://code.google.com/apis/console/'>https://code.google.com/apis/console/</a>
                </li>
                <li>Set up allowed Redirect URIs at Google API &rarr; API
                    Access. Input: http://localhost:8081/OAuth2v1/index.jsp</li>
            </ul>
            <h4>Usage</h4>
            <ol>
                <li>Add Client ID, and Client Secret parameters to <b>GoogleAuth.java</b></li>
                <li>Compile the project (<b>$ mvn clean install</b>)</li>
                <li>Deploy war to application server</li>
                <li>Browse to: <a href="http://localhost:8081/OAuth2v1/">http://localhost:8081/OAuth2v1/</a></li>
                <li>Click <b>&quot;Authenticate with google for next login&quot;</b> on top of this page</li>
            </ol>
        </div> 
    </div>
</div>
<%@include file="footer.jsp" %>