package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Cost;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.RestaurantMeta;

public interface RestaurantMapper {

    /** 注册插入用户记录 **/
    void register(Restaurant restaurant);

    /** 获取下一个ID **/
    String getNextID();

    /** 获取餐馆的meta信息 **/
    RestaurantMeta getRestaurantMeta(Restaurant restaurant);

    /** 修改位置和点名字等信息 **/
    void changeRestaurantInfo(Restaurant restaurant);

    /** 修改费用信息 **/
    void changeRestaurantFee(Cost restaurant);
}
