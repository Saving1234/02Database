package lecture.section2.run.c_preparedStatement;

import lecture.section2.common.JDBCTemplate;
import lecture.section2.model.Menu.MenuDTO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Application3 {

    public static void main(String[] args) {

        // 협업할 때 문제.
        // 깃 안에서 가져와 같은 파일을 수정하게 되면, 충돌이 일어남.
        // 다른 파일은 파일 자체가 달라서 충돌이 안나옴.
        // 같은 파일 안에 쿼리가 너무 많아지게 되면, 문제가 생기니 밖으로 빼준다.
        //xml 파일로 뺀다.

        //xml :  문서가 어떤 문서인지 설명해 줄 수 있다.
        //xml 버전 + 인코딩 + 스탠

        List<MenuDTO> menuList = new ArrayList<>();

        Scanner sc = new Scanner(System.in);
        System.out.println("메뉴 목록 :");
        String name = sc.nextLine();

        String query = "select * from tbl_menu where menu_name like concat('%', ?, '%')";

        try(Connection con = JDBCTemplate.getConnection();
                PreparedStatement pstm = con.prepareStatement(query);
                ){


            pstm.setString(1, name);

            ResultSet rSet = pstm.executeQuery(); //실행.

            while (rSet.next()){
                menuList.add(new MenuDTO(
                        rSet.getInt("menu_code"),
                        rSet.getString("menu_name"),
                        rSet.getInt("menu_price"),
                        rSet.getInt("category_code"),
                        rSet.getString("orderable_status")

                ));

            }

            for(MenuDTO menu : menuList) {

                System.out.println("메뉴" + menu);
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
