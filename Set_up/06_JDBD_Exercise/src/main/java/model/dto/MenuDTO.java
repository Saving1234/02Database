package model.dto;

import lombok.*;
@ToString
@Getter
@Setter
@AllArgsConstructor //모든 필드를 인자로 받는 생성자
@NoArgsConstructor //인자가 없는 생성자
public class MenuDTO {



    private int code;
    private String name;
    private  int price;
    private int categoryName;
    private  String orderableStatus;

}
