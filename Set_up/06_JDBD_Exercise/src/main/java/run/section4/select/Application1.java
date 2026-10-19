package run.section4.select;

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

public class Application1 {

    /*
        메뉴를 조회하는데, 메뉴번호를 입력받고
         해당 메뉴 이름, 가격, 카테고리 이름, 주문가능 여부를 출력한다

         model DTO 추가 생성
         menuDTO2 와 CategoryDTO 생성 필요.
     */


    public static void main(String[] args) {


        List<MenuDTO> menu = new ArrayList<>();


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
               menu.add(new MenuDTO(
                       result.getInt("menu_code"),
                       result.getString("menu_name"),
                       result.getInt("menu_price"),
                       result.getInt("category_code"),
                       result.getString("orderable_Status")
                       ));



           }

            System.out.println(result);

           for(MenuDTO menus : menu){
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
