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
import org.json.JSONObject;

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
            return "Exception message" + e.getMessage();
        }
        return "Updates saved successfully. <br /> <br /> Now you can login with your google account instead of your local username account.";
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
}
