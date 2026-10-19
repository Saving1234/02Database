package lecture.section2.run.b_sqlIngention;

import lecture.section2.common.JDBCTemplate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Test {

    // try- resource 문에서도 사용 가능. close.
    // 근데 두 개 다 넣어야하는 건가??

    public static void main(String[] args) {
        Connection con = JDBCTemplate.getConnection();
        try (con) { //false



            System.out.println( "con 상태 : " + con.isClosed());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }



        try { //true


            System.out.println( "con 상태 : " + con.isClosed());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

}
