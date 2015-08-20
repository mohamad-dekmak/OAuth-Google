<%@include file="header.jsp" %>
<%
    session = request.getSession();
    session.invalidate();
%>
<div class="panel panel-warning">
    <div class="panel-heading">
        <h3 class="panel-title">Sign Out from SMB215</h3>
    </div>
    <div class="panel-body">
        You have successfully logged out.
        Click <a href="https://localhost:8443/OAuth2v1"><b>here</b></a> for another login.
    </div>
</div>
<%@include file="footer.jsp" %>
