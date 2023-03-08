package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class TakeoutOrder extends Order{

    private String location;
    private String tel;

    /** 外面订单的状态 **/
    public static final int CANCELED = 0;
    public static final int TO_BE_RECEIVED = 1;
    public static final int TO_BE_MADE = 2;
    public static final int TO_BE_TOKEN = 3;
    public static final int TO_BE_ARRIVED = 4;
    public static final int FINISHED = 5;

}
