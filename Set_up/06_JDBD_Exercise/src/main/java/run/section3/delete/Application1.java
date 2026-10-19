package run.section3.delete;

import common.JDBCTemplate;
import model.dto.MenuDTO;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class Application1 {

    /*
        전체 메뉴 보여주고
        삭제할 메뉴 변호를 입력받는다
        삭제한다
     */



    public static void main(String[] args) {

        List<MenuDTO> menu = new ArrayList<>();


        Scanner sc = new Scanner(System.in);

        Connection con = JDBCTemplate.getConnection();
        PreparedStatement pstm = null;
        ResultSet rSet = null;
        Properties pro = new Properties();

        int result;




        try{



            pro.loadFromXML(new FileInputStream("src/main/java/mapper/menu.query.xml"));
            String query = "select * from tbl_menu";
            pstm = con.prepareStatement(query);
            rSet = pstm.executeQuery();




            while (rSet.next()) {
                menu.add(new MenuDTO(
                        rSet.getInt("menu_code"),
                        rSet.getString("menu_name"),
                        rSet.getInt("menu_price"),
                        rSet.getInt("category_code"),
                        rSet.getString("orderable_Status")

                ));
            }

            for(MenuDTO member: menu){
                System.out.println("member = " + member);
            }

            pstm.close();


            String query2 = pro.getProperty("deleteMenu");
            pstm = con.prepareStatement(query2);

            for(MenuDTO menus : menu){
                System.out.println(menus);
            }

            System.out.println("삭제하고 싶은 번호 입력해주세요");
            int delete = Integer.parseInt(sc.nextLine());

            pstm.setInt(1, delete);


            result = pstm.executeUpdate();
            System.out.println(result);




        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (InvalidPropertiesFormatException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        }



    }



