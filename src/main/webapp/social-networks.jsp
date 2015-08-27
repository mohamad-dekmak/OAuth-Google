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
        <div class="col-md-12">
            <div class="panel panel-info">
                <div class="panel-heading">
                    <h4 class="socail-title">Social Networks</h4>
                    <p class="socail-sub-title">Change your social network accounts to easily share content. Moreover you can login with help of them</p>
                </div>
                <div class="panel-body">
                    <div class="google-container">
                        <div class="col-md-3 social-brand-container">
                            <div class="col-md-3">
                                <img src="resources/images/google.png" />
                            </div>
                            <div class="col-md-6">
                                <h3>Google</h3>
                            </div>
                        </div>
                        <div class="clearfix">&nbsp;</div>
                        <hr />
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <p>Your <%= appName%> account is not connected to Google</p>
                            </div>
                            <div class="col-md-6">
                                <%
                                    out.println("<a href='" + helper.buildLoginUrl() + "' class='btn btn-info pull-right'>Connect</a>");
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">&nbsp;</div>
                    <div class="facebok-container">
                        <div class="col-md-3 social-brand-container">
                            <div class="col-md-3">
                                <img src="resources/images/facebook.png" />
                            </div>
                            <div class="col-md-6">
                                <h3>Facebook</h3>
                            </div>
                        </div>
                        <div class="clearfix">&nbsp;</div>
                        <hr />
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <p>Your <%= appName%> account is not connected to Facebook</p>
                            </div>
                            <div class="col-md-6">
                                <%
                                    out.println("<a href='javascript:;' class='btn btn-info pull-right'>Connect</a>");
                                %>
                            </div>
                        </div>
                    </div>
                    <div class="clearfix">&nbsp;</div>
                    <div class="facebok-container">
                        <div class="col-md-3 social-brand-container">
                            <div class="col-md-3">
                                <img src="resources/images/twitter.png" />
                            </div>
                            <div class="col-md-6">
                                <h3>Twitter</h3>
                            </div>
                        </div>
                        <div class="clearfix">&nbsp;</div>
                        <hr />
                        <div class="col-md-12">
                            <div class="col-md-6">
                                <p>Your <%= appName%> account is not connected to Twitter</p>
                            </div>
                            <div class="col-md-6">
                                <%
                                    out.println("<a href='javascript:;' class='btn btn-info pull-right'>Connect</a>");
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<%@include file="footer.jsp" %>