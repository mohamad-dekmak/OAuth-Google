<%-- 
    Document   : oauth
    Created on : Aug 25, 2015, 11:06:14 PM
    Author     : mdekmak
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="m.dekmak.GoogleAuth"%>
<%
    final GoogleAuth helper = new GoogleAuth();
%>
<%@include file="header.jsp" %>

<div class="container master-container">
    <div class="row">
        <div class="col-md-8">
            <div class="panel panel-info">
                <div class="panel-heading">Read Me First</div>
                <div class="panel-body">
                    <div class="readme">
                        <h4>Assumptions</h4>
                        <ul>
                            <li>familiarity with OOP, java, maven, and jee</li>
                            <li>java application server listening on localhost:8443</li>
                        </ul>
                        <h4>Prerequisites</h4>
                        <ul>
                            <li>Google API access credentials (Client ID, Client Secret).
                                Set it up here <a href='https://code.google.com/apis/console/'>https://code.google.com/apis/console/</a>
                            </li>
                            <li>Set up allowed Redirect URIs at Google API &rarr; API
                                Access. Input: https://localhost:8443/SMB215-OAuth-Google/index.jsp</li>
                        </ul>
                        <h4>Usage</h4>
                        <ol>
                            <li>Add Client ID, and Client Secret parameters to <b>GoogleAuth.java</b></li>
                            <li>Compile the project (<b>$ mvn clean install</b>)</li>
                            <li>Deploy war to application server</li>
                            <li>Browse to: <a href="https://localhost:8443/SMB215-OAuth-Google/">https://localhost:8443/SMB215-OAuth-Google/</a></li>
                            <li>Click <b>&quot;Authenticate with google for next login&quot;</b> on top of this page</li>
                        </ol>
                    </div> 
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="panel panel-primary">
                <div class="panel-heading">Authenticate with Google</div>
                <div class="panel-body">
                    <div class="col-md-4 no-padding">
                        <a href="#">
                            <img class="img-rounded" src="resources/images/google.png" width="128" height="128" />
                        </a>
                    </div>
                    <div class="col-md-8" style="padding-left: 24px;">
                        <div class="clearfix">&nbsp;</div>
                        <div class="clearfix">&nbsp;</div>
                        <p class="text">Authenticate with Google for next login</p>
                        <%                            out.println("<a href='" + helper.buildLoginUrl() + " class='btn btn-link no-padding'>Try now</a>");
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%@include file="footer.jsp" %>