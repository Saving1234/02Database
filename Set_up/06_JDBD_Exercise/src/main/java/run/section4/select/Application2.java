package run.section4.select;

import model.dto.MenuCategory;
import model.dto.MenuDTO;
import model.dto.MenuDTO2;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import static common.JDBCTemplate.getConnection;

public class Application2 {

    public static void main(String[] args) {

        List<MenuDTO2> menuList = new ArrayList<>();


        Scanner sc = new Scanner(System.in);


        System.out.println("조회하고 싶은 메뉴 번호 적어주세요");
        int menuId = Integer.parseInt(sc.nextLine());

        Connection con = getConnection();
        PreparedStatement pstm = null;
        Properties prop = new Properties();


        ResultSet result;
        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu.query.xml"));
            String key = prop.getProperty("selectMenu");
            System.out.println("key = " + key);

            pstm = con.prepareStatement(key);

            pstm.setInt(1, menuId);



            result = pstm.executeQuery();


            while (result.next()){

                MenuCategory category = new MenuCategory(
                        result.getInt("category_code"),
                        result.getString("category_name"),
                        result.getInt("ref_category_code")


                );


                MenuDTO2 menu2 = new MenuDTO2(
                        result.getInt("menu_code"),
                        result.getString("menu_name"),
                        result.getInt("menu_price"),
                       category,
                        result.getString("orderable_Status")
                );
                menuList.add(menu2);
            }


            for(MenuDTO2 menus : menuList){
                System.out.println("출력"+ menus );
            }


        }catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (InvalidPropertiesFormatException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
