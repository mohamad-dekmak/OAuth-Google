<%-- 
    Document   : userBanUnban
    Created on : Aug 23, 2015, 3:13:53 PM
    Author     : mdekmak
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
        } else if (request.getParameter("userAction").equals("changePassword")) {
            String username = request.getParameter("username");
            String newPassword = request.getParameter("newPassword");
            String responseMsg = db.updateUserPassword(username, newPassword);
            if (responseMsg.equals("success")) {
                strResponse = "Password changed successfully for user \"" + username + "\"";
            } else {
                strResponse = responseMsg;
            }
        } else if (request.getParameter("userAction").equals("editUser")) {
            String oldUsername = request.getParameter("oldUsername");
            String newUsername = request.getParameter("newUsername");
            JSONObject newRoles = new JSONObject();
            newRoles = new JSONObject(request.getParameter("newRoles"));
            String responseMsg = db.editUser(oldUsername, newUsername, newRoles);
            if (responseMsg.equals("success")) {
                strResponse = "Updates changed successfully for user \"" + newUsername + "\"";
            } else {
                strResponse = responseMsg;
            }
        } else if (request.getParameter("userAction").equals("addUser")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            JSONObject roles = new JSONObject();
            roles = new JSONObject(request.getParameter("roles"));
            String responseMsg = db.addUser(username, roles, password);
            strResponse = responseMsg;
        } else if (request.getParameter("userAction").equals("addUserGroup")) {
            String name = request.getParameter("name");
            String responseMsg = db.addUserGroup(name);
            strResponse = responseMsg;
        } else if (request.getParameter("userAction").equals("editUserGroup")) {
            String oldName = request.getParameter("oldName");
            String newName = request.getParameter("newName");
            String responseMsg = db.editUserGroup(oldName, newName);
            if (responseMsg.equals("success")) {
                strResponse = "Updates changed successfully for user group \"" + newName + "\"";
            } else {
                strResponse = responseMsg;
            }
        } else if (request.getParameter("userAction").equals("disconnectGoogleAccount")) {
            String username = request.getParameter("username");
            String responseMsg = db.disconnectGoogleAccount(username);
            strResponse = responseMsg;
        } else if (request.getParameter("userAction").equals("killBannedUser")) {
            String username = request.getParameter("username");
            String responseMsg = db.userIsBanned(username);
            strResponse = responseMsg;
            if (strResponse.equals("yes")) {
                session = request.getSession();
                session.invalidate();
                strResponse = "isBanned";
            } else {
                strResponse = "notBanned";
            }
        } else if (request.getParameter("userAction").equals("notifyUser")) {
            String message = request.getParameter("message");
            String sendByEmail = request.getParameter("sendByEmail");
            JSONObject users = new JSONObject();
            users = new JSONObject(request.getParameter("users"));
            String responseMsg = db.notifyUser(message, users, sendByEmail);
            strResponse = responseMsg;
        } else if (request.getParameter("userAction").equals("getPendingNotifications")) {
            String username = request.getParameter("username");
            List<String> notifications = new ArrayList<String>();
            notifications = db.getPendingNotifications(username);
            for (String s : notifications) {
                strResponse += s + "%row-separator%";
            }
        }else if (request.getParameter("userAction").equals("getCounterNotifications")) {
            String username = request.getParameter("username");
            strResponse = db.getCounterNotifications(username);
        }else if (request.getParameter("userAction").equals("addContact")) {
            String loggedUser = request.getParameter("loggedUser");
            JSONObject postData = new JSONObject();
            postData = new JSONObject(request.getParameter("data"));
            strResponse = db.addContact(postData, loggedUser);
        }else if (request.getParameter("userAction").equals("editContact")) {
            String id = request.getParameter("id");
            String loggedUser = request.getParameter("loggedUser");
            JSONObject postData = new JSONObject();
            postData = new JSONObject(request.getParameter("data"));
            strResponse = db.editContact(id, postData, loggedUser);
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
