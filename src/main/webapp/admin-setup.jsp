<%-- 
    Document   : admin-setup
    Created on : Aug 25, 2015, 9:35:55 PM
    Author     : mdekmak
--%>

<%@include file="header.jsp" %>

<div class="col-md-12">
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Manage Users</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="users-list.jsp">
                        <img class="img-rounded" src="resources/images/users_list.png" width="128" height="128" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <a href="users-list.jsp" class="btn btn-link pull-right admin-links">Manage Users</a>
                    <div class="clearfix">&nbsp;</div>
                    <div class="clearfix">&nbsp;</div>
                    <a href="user-add.jsp" class="btn btn-link pull-right admin-links">Add User</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">Manage User Groups</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="user-groups-list.jsp">
                        <img class="img-rounded" src="resources/images/user_groups_list.png" width="128" height="128" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <a href="user-groups-list.jsp" class="btn btn-link pull-right admin-links">List Groups</a>
                    <div class="clearfix">&nbsp;</div>
                    <div class="clearfix">&nbsp;</div>
                    <a href="user-group-add.jsp" class="btn btn-link pull-right admin-links">Add Group</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-primary">
            <div class="panel-heading">System Preferences</div>
            <div class="panel-body">
                <div class="col-md-4 no-padding">
                    <a href="system-preferences.jsp">
                        <img class="img-rounded" src="resources/images/system_preferences.png" width="128" height="128" />
                    </a>
                </div>
                <div class="col-md-8">
                    <div class="clearfix">&nbsp;</div>
                    <div class="clearfix">&nbsp;</div>
                    <a href="system-preferences.jsp" class="btn btn-link pull-right admin-links">Default Values</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="footer.jsp" %>