package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Material extends Transfer{

    private String mid;
    private String name;
    private double price;
    private String measure;
    private double total;
    private String rid;
    private String format;
    private String comment;
    private boolean valid;
    private double remain;

    public static final String LOCATION = "D:\\resources\\materials\\";

}
