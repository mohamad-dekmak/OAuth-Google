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
import java.util.List;

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
            preparedStatement = connection.prepareStatement("select tomcat_users.user_name, GROUP_CONCAT(tomcat_users_roles.role_name SEPARATOR '; ') AS role_name, tomcat_users.email, tomcat_users.isGoogleAuth from tomcat_users left join tomcat_users_roles on tomcat_users_roles.user_name = tomcat_users.user_name group by tomcat_users.user_name");
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                List<String> row = new ArrayList<String>();
                row.add(rs.getString("user_name"));
                row.add(rs.getString("role_name"));
                row.add(rs.getString("email"));
                row.add(rs.getString("isGoogleAuth"));
                users.add(row.toString());
            }
        } catch (Exception e) {
            users.add("Exception message" + e.getMessage());
        }
        return users;
    }
}
