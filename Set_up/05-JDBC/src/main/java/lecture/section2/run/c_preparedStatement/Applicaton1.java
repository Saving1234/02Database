package lecture.section2.run.c_preparedStatement;

import lecture.section2.model.Menu.MenuDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static lecture.section2.common.JDBCTemplate.getConnection;

public class Applicaton1 {

    public static void main(String[] args) {

        List<MenuDTO> menuList = new ArrayList<>();

        String query = "";
        String query2 = "select * from tbl_menu where menu_code = ?";
        // 쿼리는 고정. 들어가는 값만 바꿈. (쿼리를 쓰게되면 해커들이 그것을 타고 들어와 정보를 빼갈 수도 있음/ sql insection 공격
        // 사용자 입력값을 명령어가 아닌 오직 '순수한 데이터'로만 인식하게 만듦
        try(Connection con = getConnection(); // 커넥션 만들기
            PreparedStatement pstmt = con.prepareStatement(query2); //PreparedStatement






        ) {
            int menuCode = 1;
            pstmt.setInt(1, menuCode);
            ResultSet rSet = pstmt.executeQuery();

            // 사용자가

            while (rSet.next()){

                menuList.add(new MenuDTO(
                        rSet.getInt("menu_code"),
                        rSet.getString("menu_name"),
                        rSet.getInt("menu_price"),
                        rSet.getInt("category_code"),
                        rSet.getString("orderable_status")

                ));

            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        for (MenuDTO menu : menuList){
            System.out.println("menu : " + menu);
        }

    }

}
