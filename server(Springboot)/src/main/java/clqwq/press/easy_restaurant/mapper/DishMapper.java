package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Restaurant;

import java.util.HashMap;

public interface DishMapper {

    HashMap<String, String>[] getAllDishes(Restaurant restaurant);

    String getNextID();

    void insertOneDish(Dish dish);

    void changeDish(Dish dish);

    void deleteDish(Dish dish);

}
