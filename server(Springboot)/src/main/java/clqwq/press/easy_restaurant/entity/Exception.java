package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Exception {

    private String id;
    private int type;

    // 异常种类
    public static final int COST_MORE_THAN_PRICE = 1;               // 成本高于售价
    public static final int LOW_FOOD_SALES = 2;                     // 菜品销量低与均值
    public static final int LOW_MATERIAL_USED = 3;                  // 原材料使用过少
    public static final int LOW_EMPLOYEE_SALARY = 4;                // 员工薪水过低

}
