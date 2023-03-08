package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Exception;
import clqwq.press.easy_restaurant.entity.Restaurant;

public interface ExceptionMapper {

    Exception[] getAllException(Restaurant restaurant);

}
