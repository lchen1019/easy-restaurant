package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.RestaurantDao;
import clqwq.press.easy_restaurant.entity.Cost;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.RestaurantMeta;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestaurantController {

    @PostMapping("getRestaurantMeta")
    public RestaurantMeta getAllDineInOrders(@RequestBody Restaurant restaurant) {
        System.out.println(restaurant);
        RestaurantMeta restaurantMeta = new RestaurantDao().getRestaurantMeta(restaurant);
        if (restaurantMeta.getTotalNum() != 0) {
            restaurantMeta.setScore(restaurantMeta.getTotalScore() / restaurantMeta.getTotalNum());
        }
        return restaurantMeta;
    }

    @PostMapping("changeRestaurantInfo")
    public void changeRestaurantInfo(@RequestBody Restaurant restaurant) {
        System.out.println(restaurant);
        new RestaurantDao().changeRestaurantInfo(restaurant);
    }

    @PostMapping("changeRestaurantFee")
    public void changeRestaurantFee(@RequestBody Cost cost) {
        new RestaurantDao().changeRestaurantFee(cost);
    }

}
