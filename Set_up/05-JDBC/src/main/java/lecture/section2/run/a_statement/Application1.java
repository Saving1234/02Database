package lecture.section2.run.a_statement;

import lecture.section2.common.JDBCTemplate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Application1 {
    public static void main(String[] args) {

       Connection con = JDBCTemplate.getConnection();

       // 완성된 sql 문자열 실행
        Statement stmt = null;

        // ResultSet : sql 의 결과를 행 단위로 읽음
        ResultSet rSet = null;

        try {
            stmt = con.createStatement();

            String sql = "SELECT MENU_CODE, MENU_NAME FROM tbl_menu";
           rSet= stmt.executeQuery(sql);

           while (rSet.next()){
               System.out.println("sql.getInt() = " + rSet.getInt("menu_code")); // 정수열 가져오기
               System.out.println("sql.getName = " + rSet.getString("menu_name")); //문자열 가져오기
           }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

}
