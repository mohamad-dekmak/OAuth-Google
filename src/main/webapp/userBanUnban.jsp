<%-- 
    Document   : userBanUnban
    Created on : Aug 23, 2015, 3:13:53 PM
    Author     : mdekmak
--%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="org.json.JSONObject"%>
<%@page import="m.dekmak.Database"%>
<%
    Database db = new Database();
    String strResponse = "";
    if (request.getParameter("userAction") != null) {
        if (request.getParameter("userAction").equals("banUser")) {
            String username = request.getParameter("username");
            String responseMsg = db.updateUserBannedStatus(request.getParameter("username"), request.getParameter("banUser"));
            if (responseMsg.equals("success")) {
                strResponse = "User \"" + username + "\" banned successfully";
            } else {
                strResponse = responseMsg;
            }
        } else if (request.getParameter("userAction").equals("unbanUser")) {
            String username = request.getParameter("username");
            String responseMsg = db.updateUserBannedStatus(request.getParameter("username"), request.getParameter("banUser"));
            if (responseMsg.equals("success")) {
                strResponse = "User \"" + username + "\" unbanned successfully";
            } else {
                strResponse = responseMsg;
            }
        }
    } else {
        strResponse = "user action not defined";
    }
%>
<%
    JSONObject obj = new JSONObject();
    obj.put("data", strResponse);
    out.print(obj);
    out.flush();
%>
