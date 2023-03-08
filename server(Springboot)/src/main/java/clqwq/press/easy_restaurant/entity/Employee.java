package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Employee extends Transfer{

    private String eid;
    private String name;
    private String home;
    private String rid;
    private double salary;
    private boolean sex;
    private String password;
    private boolean valid;


    /** 权限控制 **/
    private boolean buyer;      // 采购的权限，可以看原材料的组成，余量
    private boolean server;     // 可以管理订单
    private boolean manager;    // 可以看数据分析，管理员工

}
