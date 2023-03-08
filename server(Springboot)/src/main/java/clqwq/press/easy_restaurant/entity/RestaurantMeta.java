package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class RestaurantMeta {

    private String rid;
    private String name;
    private String tel;
    private int totalDish;
    private int totalNum;
    private int totalMaterial;
    private int totalOrder;
    private double totalScore;
    private int totalEmployee;
    private int totalTable;
    private String location;
    private double score;       // 计算出来的，数据库中没有

}
