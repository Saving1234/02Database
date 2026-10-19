package lecture.section2.model.Menu;

import lombok.*;

// tbl_menu의 한행을 계층간 전달하기 위한 데이터 객체
@Setter
@Getter
@AllArgsConstructor //모든 필드를 인자로 받는 생성자
@NoArgsConstructor //인자가 없는 생성자
@ToString

public class MenuDTO {

    private int code;
    private String name;
    private int price;
    private int categoryCode;
    private String orderableStatus;

}