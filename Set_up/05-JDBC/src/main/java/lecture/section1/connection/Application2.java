package lecture.section1.connection;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Application2 {

    /*
        Connection 객체를 외부 설정 파일을 이용해서 만들기
        보안적인 장점
        소스코드에 db 접속 정보가 공개되어 모두가 접솔 할 수 있는 상태를 감지할 수 있음
        빌저적인 장점
     */

    public static void main(String[] args) {

        Connection con = null; // jav.sql 커넥션으로 .
        // db 접속을 위한 연결 객체 (statement 생성위해)
        Properties prop = new Properties();

        //클래스 이름 정의
        try {

            prop.load(new FileReader("src/main/java/lecture/section1/configdb/configdb.properties"));
            //드라이버 등록


            System.out.println("pp" + prop);
            String driver = prop.getProperty("driver");
            String url = prop.getProperty("url");
            String user = prop.getProperty("user");
            String password = prop.getProperty("password");
            Class.forName(driver);

            // 기존 커넥션안에 넣었던 url 등에 값을 넣은 변수를 넣기.

            try {
                con = DriverManager.getConnection(url,
                        user, password);
                System.out.println(con); // 커넥션 객체 확인.

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            if (con != null) {
                try {
                    con.close(); // 외부에서 가져온거니까 반납.
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }  // 여기서 깃허브에 올려버리면 아이디와 비번도 올라감. properties 파일에 빼기.,


        }

    }
}
