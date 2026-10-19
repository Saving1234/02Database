package lecture.section1.connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Application {

    public static void main(String[] args) {

        Connection con = null; // jav.sql 커넥션으로 .
        // db 접속을 위한 연결 객체 (statement 생성위해)

        //클래스 이름 정의
        try {
            //드라이버 등록
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 이 경로의 드라이버를 준비시키겠다.

            //url은 커넥터에서 pricep - url보고.
            //어떤 데이터베이스에 연결할거냐. 연결.
            // 계정명과 password 넣기.

            try {
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/menudb",
                        "kyc", "1234");
                System.out.println(con); // 커넥션 객체 확인.

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }finally {
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
