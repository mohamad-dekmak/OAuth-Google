<%-- 
    Document   : index
    Created on : Jun 26, 2015, 03:37:52 PM
    Author     : mdekmak
--%>

<%@include file="header.jsp" %>

<script type="text/javascript">
    $(function () {
        // to remove the conflict in the Google GET Params between the "login action in login form" and "authenticate action in home page" 
        clearGoogleParamsFromURL();
    });
</script>
<div class="page-container">
    <%!
        String userInfo, userEmail, userId;
    %>
    <%        final GoogleAuth helper = new GoogleAuth();
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
<div class="col-md-12">
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Dashboard</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="#">
                        <img class="img-rounded" src="resources/images/dashboard.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Visualize your main data for a better monitoring and fast access to the information.</p>
                    <a href="#" class="btn btn-link no-padding">360° Dashboard</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Contact</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="#">
                        <img class="img-rounded" src="resources/images/contact.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Manage your contacts and related information.</p>
                    <a href="#" class="btn btn-link no-padding">Add</a>&nbsp;&nbsp; - &nbsp;&nbsp;
                    <a href="#" class="btn btn-link no-padding">Search</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Administration & Setup</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="admin-setup.jsp">
                        <img class="img-rounded" src="resources/images/settings.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Setup your instance by managing your group list, adding users & more.</p>
                    <a href="admin-setup.jsp" class="btn btn-link no-padding">Edit</a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="col-md-12">
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Calendar</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="#">
                        <img class="img-rounded" src="resources/images/calendar.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Share your Calendar with your colleagues for a better Visibility & Collaboration. Schedule Events & more.</p>
                    <a href="#" class="btn btn-link no-padding">Open Calendar</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Task Management</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="#">
                        <img class="img-rounded" src="resources/images/task.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Build your team's to-do lists. Track Notes History. Manage your Priorities, Due Dates, Resources & more.</p>
                    <a href="#" class="btn btn-link no-padding">Add</a>&nbsp;&nbsp; - &nbsp;&nbsp;
                    <a href="#" class="btn btn-link no-padding">Search</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Accounting Management</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="#">
                        <img class="img-rounded" src="resources/images/accounting.png" width="115" height="115" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <p class="text">Track and Categorize your Expenses & Income. Generate your Invoices and record Payments & more.</p>
                    <a href="#" class="btn btn-link no-padding">Edit</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>