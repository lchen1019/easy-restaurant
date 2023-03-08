package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.*;
import org.apache.catalina.mapper.Mapper;

import java.util.HashMap;

public interface OrderMapper {

    /** 获取所有的堂食订单 **/
    HashMap<String, String>[] getAllDineInOrders(Restaurant restaurant);

    /** 获取所有的外卖订单 **/
    HashMap<String, String>[] getAllTakeOutOrders(Restaurant restaurant);

    /** 修改订单的状态 **/
    void changDineInOrderState(Order order);
    void changTakeOutOrderState(Order order);

    /** 根据座位号，获取堂食订单中正在使用的那个 **/
    HashMap<String, String>[] getDiningOrder(Table table);

    /** 修改堂食订单的点餐信息和总价格 **/
    void changeDineInOrder(Order dineInOrder);

    /** 新增堂食订单，对点餐程序和管理程序开放**/
    void insertOneDineInOrder(DineInOrder dineInOrder);

    /** 新增外卖订单，对外卖平台提供的接口 **/
    void insertOneTakeOutOrder(TakeoutOrder takeoutOrder);

    /** 获取下一个堂食ID **/
    String getNextDineInID();

    /** 获取下一个外卖ID **/
    String getNextTakeOutID();



//    /** 删除堂食订单 **/
//    void deleteDineInOrder(DineInOrder dineInOrder);
//
//    /** 删除外卖订单 **/
//    void deleteTakeOutOrder(TakeoutOrder takeoutOrder);
}
