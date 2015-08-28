/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package m.dekmak;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;
import static org.json.JSONObject.NULL;

/**
 *
 * @author mdekmak
 */
public class Database {

    public static final String MYSQL_DRIVER = "com.mysql.jdbc.Driver";
    public static final String MYSQL_URL = "jdbc:mysql://localhost/tomcat_realm?user=root&password=123";

    enum UserTableColumns {

        USERNAME, USERCODE;
    }

    private final String jdbcDriverStr;
    private final String jdbcURL;

    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;
    private PreparedStatement preparedStatement;

    public Database() {
        this.jdbcDriverStr = MYSQL_DRIVER;
        this.jdbcURL = MYSQL_URL;
    }

    public String updateUserInfo(String user_name, String user_email, String user_google_id) {
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.isGoogleAuth = ?, tomcat_users.email = ?, tomcat_users.userGoogleId = ? where tomcat_users.user_name = ?");
            preparedStatement.setString(1, "yes");
            preparedStatement.setString(2, user_email);
            preparedStatement.setString(3, user_google_id);
            preparedStatement.setString(4, user_name);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            return "error";
        }
        return "success";
    }

    public String[] getUserCredentials(String user_email, String user_google_id) {
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select user_name, password from tomcat_users where isGoogleAuth = ? AND email = ? AND userGoogleId = ?");
            preparedStatement.setString(1, "yes");
            preparedStatement.setString(2, user_email);
            preparedStatement.setString(3, user_google_id);
            ResultSet rs = preparedStatement.executeQuery();
            String userName = "";
            String pass = "";
            while (rs.next()) {
                userName = rs.getString("user_name");
                pass = rs.getString("password");
            }
            return new String[]{userName, pass};
        } catch (Exception e) {
            return new String[]{"Exception message" + e.getMessage()};
        }
    }

    public List<String> getUsersList() {
        List<String> users = new ArrayList<String>();
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select tomcat_users.user_name, GROUP_CONCAT(tomcat_users_roles.role_name SEPARATOR '; ') AS role_name, tomcat_users.email, tomcat_users.isGoogleAuth, \"*action*\" AS action, tomcat_users.isBanned from tomcat_users left join tomcat_users_roles on tomcat_users_roles.user_name = tomcat_users.user_name group by tomcat_users.user_name");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                List<String> row = new ArrayList<String>();
                row.add(rs.getString("user_name"));
                row.add(rs.getString("role_name"));
                row.add(rs.getString("email"));
                row.add(rs.getString("isGoogleAuth"));
                row.add(rs.getString("isBanned"));
                row.add(rs.getString("action"));
                users.add(row.toString());
            }
        } catch (Exception e) {
            users.add("Exception message" + e.getMessage());
        }
        return users;
    }

    public String updateProfilePassword(String profileName, String oldPaswword, String newPassword) {
        String msg = "";
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select user_name, password from tomcat_users where user_name = ?");
            preparedStatement.setString(1, profileName);
            ResultSet rs = preparedStatement.executeQuery();
            String userName = "";
            String pass = "";
            while (rs.next()) {
                userName = rs.getString("user_name");
                pass = rs.getString("password");
            }
            if (userName == "" || pass == "") {
                msg = "User does not matched in local database";
            } else {
                MD5Digest md5 = new MD5Digest();
                // check if old password is correct
                String hashPwd = md5.generate(oldPaswword);
                if (pass.equals(hashPwd)) {
                    // update user password in DB
                    hashPwd = md5.generate(newPassword);
                    statement = connection.createStatement();
                    preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.password = ? where tomcat_users.user_name = ?");
                    preparedStatement.setString(1, hashPwd);
                    preparedStatement.setString(2, profileName);
                    if (preparedStatement.executeUpdate() == 0) {
                        msg = "Failed to change user password (db problem)";
                    } else {
                        msg = "success";
                    }
                } else {
                    msg = "Old password does not matched in local database";
                }
            }
        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String updateUserBannedStatus(String user_name, String isBanned) {
        String msg = "";
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.isBanned = ? where tomcat_users.user_name = ?");
            preparedStatement.setString(1, isBanned);
            preparedStatement.setString(2, user_name);
            if (preparedStatement.executeUpdate() == 0) {
                msg = "Failed to change user banned status (db problem)";
            } else {
                msg = "success";
            }
        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String updateUserPassword(String user_name, String password) {
        String msg = "";
        try {
            MD5Digest md5 = new MD5Digest();
            String hashPwd = md5.generate(password);
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.password = ? where tomcat_users.user_name = ?");
            preparedStatement.setString(1, hashPwd);
            preparedStatement.setString(2, user_name);
            if (preparedStatement.executeUpdate() == 0) {
                msg = "Failed to change user password (db problem)";
            } else {
                msg = "success";
            }
        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String editUser(String oldUsername, String newUsername, JSONObject newRoles) {
        String msg = "";
        try {
            int completeScript = 1;
            int updateUsername = 0;
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();

            // check if username has changed and the new value is already taken and exists in db. else, update username in db  
            if (!oldUsername.equals(newUsername)) {
                preparedStatement = connection.prepareStatement("select user_name from tomcat_users where user_name = ?");
                preparedStatement.setString(1, newUsername);
                ResultSet rs = preparedStatement.executeQuery();
                String dbUserName = "";
                while (rs.next()) {
                    dbUserName = rs.getString("user_name");
                }
                if (dbUserName != "") { // new username already exists in DB
                    msg = "The new username already taken. Please choose another";
                    completeScript = 0;
                } else {
                    updateUsername = 1;
                }
            }
            if (completeScript == 1) {
                // remove old roles
                statement = connection.createStatement();
                preparedStatement = connection.prepareStatement("delete from tomcat_users_roles where tomcat_users_roles.user_name = ?");
                preparedStatement.setString(1, oldUsername);
                if (preparedStatement.executeUpdate() == 0) {
                    msg = "Failed to change roles (db problem)";
                    completeScript = 0;
                } else {
                    msg = "success";
                    completeScript = 1;
                }
                if (completeScript == 1) {
                    if (updateUsername == 1) {
                        // update username in DB
                        statement = connection.createStatement();
                        preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.user_name = ? where tomcat_users.user_name = ?");
                        preparedStatement.setString(1, newUsername);
                        preparedStatement.setString(2, oldUsername);
                        if (preparedStatement.executeUpdate() == 0) {
                            msg = "Failed to change username (db problem)";
                            completeScript = 0;
                        } else {
                            msg = "success";
                            completeScript = 1;
                        }
                    }
                    if (completeScript == 1) {
                        // insert new roles
                        Iterator<?> roles = newRoles.keys();
                        while (roles.hasNext()) {
                            String role = (String) roles.next();
                            statement = connection.createStatement();
                            preparedStatement = connection.prepareStatement("INSERT INTO tomcat_users_roles"
                                    + "(user_name, role_name) VALUES"
                                    + "(?,?)");
                            preparedStatement.setString(1, newUsername);
                            preparedStatement.setString(2, role);
                            preparedStatement.executeUpdate();
                        }
                    }
                }
            }
        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String addUser(String user_name, JSONObject user_groups, String password) {
        String msg = "";
        int completeScript = 1;
        try {
            MD5Digest md5 = new MD5Digest();
            String hashPwd = md5.generate(password);
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select user_name from tomcat_users where user_name = ?");
            preparedStatement.setString(1, user_name);
            ResultSet rs = preparedStatement.executeQuery();
            String dbUserName = "";
            while (rs.next()) {
                dbUserName = rs.getString("user_name");
            }
            if (dbUserName != "") { // username already exists in DB
                msg = "Username already taken. Please choose another";
                completeScript = 0;
            } else {
                preparedStatement = connection.prepareStatement("INSERT INTO tomcat_users"
                        + "(user_name, password) VALUES"
                        + "(?,?)");
                preparedStatement.setString(1, user_name);
                preparedStatement.setString(2, hashPwd);
                if (preparedStatement.executeUpdate() == 0) {
                    msg = "Failed to add user (db problem)";
                } else {
                    msg = "success";
                    // link roles
                    Iterator<?> roles = user_groups.keys();
                    while (roles.hasNext()) {
                        String role = (String) roles.next();
                        statement = connection.createStatement();
                        preparedStatement = connection.prepareStatement("INSERT INTO tomcat_users_roles"
                                + "(user_name, role_name) VALUES"
                                + "(?,?)");
                        preparedStatement.setString(1, user_name);
                        preparedStatement.setString(2, role);
                        preparedStatement.executeUpdate();
                    }
                }
            }

        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public List<String> getUserGroupsList() {
        List<String> users = new ArrayList<String>();
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select tomcat_roles.role_name, \"*action*\" AS action from tomcat_roles");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                List<String> row = new ArrayList<String>();
                row.add(rs.getString("role_name"));
                row.add(rs.getString("action"));
                users.add(row.toString());
            }
        } catch (Exception e) {
            users.add("Exception message" + e.getMessage());
        }
        return users;
    }

    public String addUserGroup(String name) {
        String msg = "";
        int completeScript = 1;
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select role_name from tomcat_roles where role_name = ?");
            preparedStatement.setString(1, name);
            ResultSet rs = preparedStatement.executeQuery();
            String dbGroupName = "";
            while (rs.next()) {
                dbGroupName = rs.getString("role_name");
            }
            if (dbGroupName != "") { // username already exists in DB
                msg = "Group name already taken. Please choose another";
                completeScript = 0;
            } else {
                preparedStatement = connection.prepareStatement("INSERT INTO tomcat_roles"
                        + "(role_name) VALUES"
                        + "(?)");
                preparedStatement.setString(1, name);
                if (preparedStatement.executeUpdate() == 0) {
                    msg = "Failed to add user group (db problem)";
                } else {
                    msg = "success";
                }
            }

        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String editUserGroup(String oldName, String newName) {
        String msg = "";
        try {
            int completeScript = 1;
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            // check if name has changed and the new value is already taken and exists in db. else, update name in db  
            if (!oldName.equals(newName)) {
                preparedStatement = connection.prepareStatement("select role_name from tomcat_roles where role_name = ?");
                preparedStatement.setString(1, newName);
                ResultSet rs = preparedStatement.executeQuery();
                String dbName = "";
                while (rs.next()) {
                    dbName = rs.getString("role_name");
                }
                if (dbName != "") { // new name already exists in DB
                    completeScript = 0;
                }
            }
            if (completeScript == 1) {
                // check if new name is equal the static roles (list of static roles not editable)
                ConfigProperties confProp = new ConfigProperties();
                String userGroupsNotEditable = confProp.getPropValue("userGroupsNotEditable");
                String[] params = userGroupsNotEditable.split(",");
                outerloop:
                for (int j = 0; j < params.length; j++) {
                    String text = params[j];

                    if (text.startsWith("[")) {
                        text = text.substring(1);
                    }
                    if (text.endsWith("]")) {
                        text = text.substring(0, text.length() - 1);
                    }
                    text = text.substring(1);
                    text = text.substring(0, text.length() - 1);
                    if (text.equals(newName)) {
                        completeScript = 0;
                        break outerloop;
                    } else if (text.equals(oldName)) {
                        completeScript = 0;
                        break outerloop;
                    }
                }
                if (completeScript == 1) {
                    // select related users to be stored, then remove the relation of old role
                    // and insert the new relations of users with the new role
                    statement = connection.createStatement();
                    preparedStatement = connection.prepareStatement("select user_name from tomcat_users_roles where role_name = ?");
                    preparedStatement.setString(1, oldName);
                    ResultSet rs = preparedStatement.executeQuery();
                    String dbUserName = "";
                    ArrayList<String> dbUsers = new ArrayList<String>();
                    while (rs.next()) {
                        dbUserName = rs.getString("user_name");
                        dbUsers.add(dbUserName);
                    }
                    if (dbUsers.isEmpty()) { // old group did not have relations with users
                        // update new name in roles table
                        statement = connection.createStatement();
                        preparedStatement = connection.prepareStatement("update tomcat_roles set tomcat_roles.role_name = ? where tomcat_roles.role_name = ?");
                        preparedStatement.setString(1, newName);
                        preparedStatement.setString(2, oldName);
                        if (preparedStatement.executeUpdate() == 0) {
                            msg = "Failed to change name (db problem)";
                        } else {
                            msg = "success";
                        }
                    } else { // old group has relations with users
                        statement = connection.createStatement();
                        preparedStatement = connection.prepareStatement("delete from tomcat_users_roles where tomcat_users_roles.role_name = ?");
                        preparedStatement.setString(1, oldName);
                        if (preparedStatement.executeUpdate() == 0) {
                            msg = "Failed to remove old relations (db problem)";
                        } else {
                            // update new name in roles table
                            statement = connection.createStatement();
                            preparedStatement = connection.prepareStatement("update tomcat_roles set tomcat_roles.role_name = ? where tomcat_roles.role_name = ?");
                            preparedStatement.setString(1, newName);
                            preparedStatement.setString(2, oldName);
                            if (preparedStatement.executeUpdate() == 0) {
                                msg = "Failed to change name (db problem)";
                            } else {
                                for (String user : dbUsers) {
                                    statement = connection.createStatement();
                                    preparedStatement = connection.prepareStatement("INSERT INTO tomcat_users_roles"
                                            + "(user_name, role_name) VALUES"
                                            + "(?,?)");
                                    preparedStatement.setString(1, user);
                                    preparedStatement.setString(2, newName);
                                    preparedStatement.executeUpdate();
                                }
                                msg = "success";
                            }
                        }
                    }
                } else {
                    msg = "Please choose another group name, this group is related to system groups";
                }
            } else {
                msg = "The new name already taken. Please choose another";
            }
        } catch (Exception e) {
            msg = "Exception message: " + e.getMessage();
        }
        return msg;
    }

    public String[] getUserDetails(String user_email) {
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select user_name, isGoogleAuth, email from tomcat_users where user_name = ?");
            preparedStatement.setString(1, user_email);
            ResultSet rs = preparedStatement.executeQuery();
            String userName = "";
            String isGoogleAuth = "";
            String email = "";
            while (rs.next()) {
                userName = rs.getString("user_name");
                isGoogleAuth = rs.getString("isGoogleAuth");
                email = rs.getString("email");
            }
            return new String[]{userName, isGoogleAuth, email};
        } catch (Exception e) {
            return new String[]{"Exception message" + e.getMessage()};
        }
    }

    public String disconnectGoogleAccount(String user_name) {
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("update tomcat_users set tomcat_users.isGoogleAuth = ?, tomcat_users.email = ?, tomcat_users.userGoogleId = ? where tomcat_users.user_name = ?");
            preparedStatement.setString(1, "no");
            preparedStatement.setString(2, "");
            preparedStatement.setString(3, "");
            preparedStatement.setString(4, user_name);
            preparedStatement.executeUpdate();
        } catch (Exception e) {
            return "Exception message" + e.getMessage();
        }
        return "success";
    }
    
    public String userIsBanned(String user_email) {
        try {
            Class.forName(jdbcDriverStr);
            connection = DriverManager.getConnection(jdbcURL);
            statement = connection.createStatement();
            preparedStatement = connection.prepareStatement("select isBanned from tomcat_users where user_name = ?");
            preparedStatement.setString(1, user_email);
            ResultSet rs = preparedStatement.executeQuery();
            String isBanned = "";
            while (rs.next()) {
                isBanned = rs.getString("isBanned");
            }
            return isBanned;
        } catch (Exception e) {
            return "";
        }
    }
}
