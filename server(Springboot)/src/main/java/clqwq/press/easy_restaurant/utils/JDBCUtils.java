package clqwq.press.easy_restaurant.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;

public class JDBCUtils {

    private static String url;
    private static String username;
    private static String password;
    private static Connection connection = null;
    private static Statement statement = null;


    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        Properties pro = new Properties();
        InputStream in = JDBCUtils.class.getClassLoader().getResourceAsStream("config.properties");
        try {
            pro.load(in);
            url = pro.getProperty("url");
            username = pro.getProperty("username");
            password = pro.getProperty("password");
            connection = DriverManager.getConnection(url, username, password);
            if(connection==null){
                System.out.println("connection 为空");
            }else{
                System.out.println("asdasd");
            }
            statement = connection.createStatement();
        } catch (SQLException | IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws SQLException {

    }

    /**
     * @description 在jdbc中获取preparedStatement对象
     * @author Chen Lin
     * @date 2021/10/9 15:48
     * @return java.sql.PreparedStatement
     */
    public static PreparedStatement getConnection(String sql){
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return preparedStatement;
    }
}
