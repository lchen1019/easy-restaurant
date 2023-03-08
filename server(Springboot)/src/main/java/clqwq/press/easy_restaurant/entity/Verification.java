package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Verification {

    private String tel;
    private int code;
    private String time;
    private int type;
    /** type取值 **/
    public static final int REGISTER = 1;
    public static final int RESET_PASSWORD = 2;
    public static final int LOGIN = 3;
}
