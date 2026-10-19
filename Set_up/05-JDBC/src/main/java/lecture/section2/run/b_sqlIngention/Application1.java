package lecture.section2.run.b_sqlIngention;

import lecture.section2.common.JDBCTemplate;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import static lecture.section2.common.JDBCTemplate.close;
import static lecture.section2.common.JDBCTemplate.getConnection;

public class Application1 {

    private static String menuName = "'OR 1=1 AND menu_name = '한우딸기국밥";
    private static String orderableStatus = "Y";

    public static void main(String[] args) {

        Connection con = getConnection();

        Statement stmt = null;
        ResultSet rSet = null;

        String query = "SELECT * FROM tbl_menu where menu-name = '" + menuName + "' AND orderableStatus = '"+ orderableStatus + '"';

        try {
           stmt = con.createStatement();
           rSet= stmt.executeQuery(query);


           if(rSet.next()){
               System.out.println(rSet.getString("menu_name") + "메뉴는 주문가능합니다");
           }else{
               System.out.println( "주문가능한 메뉴가 없습니다");
           }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally { // Connection 자동으로 닫히지만,

            close(rSet);
            close(stmt);
            close(con);

        }



    }
}
