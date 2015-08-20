<%-- 
    Document   : list
    Created on : Aug 20, 2015, 9:58:11 AM
    Author     : mdekmak
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="m.dekmak.Database"%>
<%@include file="header.jsp" %>
<div class="page-container">

    <div class="panel panel-default">
        <div class="panel-heading">Tomcat Users List</div>
        <table class="table">
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
</div>
<%@include file="footer.jsp" %>