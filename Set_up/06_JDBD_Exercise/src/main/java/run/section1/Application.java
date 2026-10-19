package run.section1;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

public class Application {

    public static void main(String[] args) throws FileNotFoundException {

        Connection con = getConnection();
        PreparedStatement psmt = null;
        System.out.println(con);

        Properties prop = new Properties();
       String query = prop.getProperty("insetmenu"); // 키값으로 쿼리 꺼내기
        int result;
        try {
            prop.loadFromXML(new FileInputStream("src/mainjava/mapper/menu.query.xml")); //

            psmt = con.prepareStatement(query); // PreparedStatement 객체 생성.

            psmt.setString(1, "봉골레청국장");
            psmt.setInt(2, 50000);
            psmt.setInt(3, 1);
            psmt.setString(4, "Y");

            // 결과


            // executeUpdate() : INSERT, UPDATE,DELETE 문에 사용 / 쿼리에 영향받은 행의 수를 반환

           ResultSet rSet = psmt.executeQuery();
           result= psmt.executeUpdate();


        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            close(psmt);
            close(con);
        }

        System.out.println("result" + result);


    }

}
