package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class DineInOrder extends Order{

    private String tid;     // 使用的桌子


    public static final int DINING = 1;
    public static final int FINISHED = 2;
}
