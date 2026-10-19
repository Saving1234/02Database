package model.dto;
import lombok.*;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MenuDTO2 {

    private int code;
    private String name;
    private int price;
    private MenuCategory category;
    private String orderableStatus;
}
