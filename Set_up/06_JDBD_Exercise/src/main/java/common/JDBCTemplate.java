package common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class JDBCTemplate {


    // connection 반환 받을 수 있는 메소드로 변경.
    public static Connection getConnection() {

        Connection con = null;
        Properties prop = new Properties();

        try {

            prop.load(new FileReader("src/main/java/config/db.properties"));

            System.out.println("설정파일을 읽어 왔습니다...");

            // properties 값 꺼내기
            String driver = prop.getProperty("driver");
            String url = prop.getProperty("url");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");

            //드라이버 설정.
            Class.forName(driver);

            // 기존 커넥션안에 넣었던 url 등에 값을 넣은 변수를 넣기.

            try {
                con = DriverManager.getConnection(url,
                        prop); //properties 바로 꺼내오도록 할 수도 있다. url은 따로 정해줘야함.
                System.out.println("커넥션 생성이 완료되었습니다");


            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (ClassNotFoundException | IOException e) {
            e.printStackTrace();

        }
        return con;

    }

    // 여기서 깃허브에 올려버리면 아이디와 비번도 올라감. properties 파일에 빼기.,
      public static void close(Connection con){
          try {
              if(con != null & !con.isClosed()){
                  con.close();

              }
          } catch (SQLException e) {
              e.printStackTrace();
          }

      }

    public static void close(Statement stmt){
        try {
            if(stmt != null & !stmt.isClosed()){
                stmt.close();

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void close(PreparedStatement pstm){

        try {

            if(pstm != null){
                pstm.close();
            if(pstm == null){
                return;
            }}
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public static void close(ResultSet rSet){
        try {
            if(rSet != null & !rSet.isClosed()){
                rSet.close();

            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

}
