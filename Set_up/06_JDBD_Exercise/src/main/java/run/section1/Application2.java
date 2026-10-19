package run.section1;

import model.dto.MenuDTO;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Scanner;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

public class Application2 {

    public static void main(String[] args) throws FileNotFoundException {


        Scanner sc = new Scanner(System.in);

        System.out.print("메뉴의 이름을 입력해주세요 : ");
        String menuName = sc.nextLine();

        System.out.print("메뉴 가격을 입력하세요 : ");
        int menuPrice = sc.nextInt();

        System.out.print("카테고리 코드를 입력하세요 : ");
        int categoryCode = sc.nextInt();

        System.out.print("판매 여부를 결정해주세요(Y/N) : ");
        sc.nextLine();
        String orderableStatus = sc.nextLine().toUpperCase();

        MenuDTO newMenu = new MenuDTO();
        newMenu.setName(menuName);
        newMenu.setPrice(menuPrice);
        newMenu.setCategoryName(categoryCode);
        newMenu.setOrderableStatus(orderableStatus);


        Connection con = getConnection();
        PreparedStatement psmt = null;
        System.out.println(con);

        Properties prop = new Properties();
       String query = prop.getProperty("insertMenu"); // 키값으로 쿼리 꺼내기
        int result;
        try {
            prop.loadFromXML(new FileInputStream("src/mainjava/mapper/menu.query.xml")); //

            psmt = con.prepareStatement(query); // PreparedStatement 객체 생성.

            psmt.setString(1, newMenu.getName());
            psmt.setInt(2, newMenu.getPrice());
            psmt.setInt(3,newMenu.getCategoryName() );
            psmt.setString(4, newMenu.getOrderableStatus());

            // 결과


            // executeUpdate() : INSERT, UPDATE,DELETE 문에 사용 / 쿼리에 영향받은 행의 수를 반환

           //ResultSet rSet = psmt.executeQuery();
           result= psmt.executeUpdate();


        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }finally {
            close(psmt);
            close(con);
        }

        System.out.println("result" + result);


    }

}
