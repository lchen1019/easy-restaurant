package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Table {

    private String tid;
    private String rid;
    private int state;
    private String location;
    private int num;
    private boolean valid;

    public static final int USING = 1;
    public static final int AVAILABLE = 2;
}
