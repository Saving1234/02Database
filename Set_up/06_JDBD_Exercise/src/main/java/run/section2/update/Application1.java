package run.section2.update;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.InvalidPropertiesFormatException;
import java.util.Properties;
import java.util.Scanner;

import static common.JDBCTemplate.getConnection;

public class Application1 {
/*
    변경할 메뉴 번호 입력 받고 해당 메뉴의 변경사항을 입력받는다 (메뉴 이름, 메뉴 가격)
    메뉴 변경한다
 */

    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.println("변경할 메뉴 번호 적어주세요");
        int menuId = Integer.parseInt(sc.nextLine());

        System.out.println("수정할 메뉴 이름 적어주세요");
        String menuName = sc.nextLine();

        System.out.println("수정할 메뉴 가격 적어주세요");
        int menuPrice = Integer.parseInt(sc.nextLine());


        Connection con = getConnection();
        PreparedStatement pstm = null;
        Properties prop = new Properties();

        int result;
        try {
            prop.loadFromXML(new FileInputStream("src/main/java/mapper/menu.query.xml"));
            String key = prop.getProperty("updateMenu");
            System.out.println("key = " + key);

            pstm = con.prepareStatement(key);

            pstm.setString(1, menuName);
            pstm.setInt(2,menuPrice);
            pstm.setInt(3,menuId);


            result = pstm.executeUpdate();

            System.out.println("결과" + result);


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
