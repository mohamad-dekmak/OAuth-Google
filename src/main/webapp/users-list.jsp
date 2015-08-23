<%-- 
    Document   : users-list
    Created on : Aug 20, 2015, 06:24:09 PM
    Author     : mdekmak
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="m.dekmak.Database"%>
<%@include file="header.jsp" %>

<div class="page-container">
    <div class="panel panel-default">
        <div class="panel-heading">Users List</div>
        <table class="table">
            <thead>
            <th style="width: 400px;">Username "Local Account"</th>
            <th style="width: 400px;">User Group "Role"</th>
            <th style="width: 400px;">Email "Google Account"</th>
            <th style="width: 400px;">Has Google Auth</th>
            <th style="width: 400px;">Is Banned</th>
            <th style="width: 400px;">Actions</th>
            </thead>
            <tbody>
                <%                    List<String> users = new ArrayList<String>();
                    Database db = new Database();
                    users = db.getUsersList();
                    for (int i = 0; i < users.size(); i++) {
                        String cell = (String) users.get(i);
                        String[] params = cell.split(",");
                %>
                <tr>
                    <%
                        for (int j = 0; j < params.length; j++) {
                            String userName = params[0].substring(1);
                            String text = params[j];
                            if (text.startsWith("[")) {
                                text = text.substring(1);
                            }
                            if (text.endsWith("]")) {
                                text = text.substring(0, text.length() - 1);
                            }
                            if (j == 5) { // "*action*"
                    %>
                    <td style="width: 400px;">
                        <button type="button" class="btn btn-default" aria-label="Left Align" title="Edit">
                            <span class="glyphicon glyphicon-edit" aria-hidden="true"></span>
                        </button>
                        <button type="button" class="btn btn-default" aria-label="Left Align" title="Change Password">
                            <span class="glyphicon glyphicon-wrench" aria-hidden="true"></span>
                        </button>
                        <%
                            String isBanned = params[j - 1].substring(1, 3); // banned come from db as " no"
                            if (isBanned.equals("no")) {
                                isBanned = "no";
                        %>
                        <button type="button" class="btn btn-default" aria-label="Left Align" title="Ban" onclick="banUnbanUser('<%= userName%>', '<%= isBanned%>');">
                            <span class="glyphicon glyphicon-ban-circle" aria-hidden="true"></span>
                        </button>
                        <%
                        } else {
                            isBanned = "yes";
                        %>
                        <button type="button" class="btn btn-default" aria-label="Left Align" title="Un-Ban" onclick="banUnbanUser('<%= userName%>', '<%= isBanned%>');">
                            <span class="glyphicon glyphicon-ok-sign" aria-hidden="true"></span>
                        </button>
                        <%
                            }
                        %>
                    </td>
                    <%
                    } else {
                    %>
                    <td style="width: 400px;"><%= text%></td>
                    <%
                            }
                        }
                    %>
                </tr>
                <%
                    }%>

            </tbody>
        </table>
    </div>
</div>

<%@include file="footer.jsp" %>