package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Order {

    protected String oid;
    protected String rid;
    protected String startTime;
    protected String finishTime;
    protected String dishes_;   // 用于JSON存储
    protected SimpleDish[] dishes;
    protected int state;
    protected String comment;
    protected double score;
    protected double price;
    protected boolean valid;
}
