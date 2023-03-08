package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Table;

public interface TableMapper {

    Table[] getAllTable(Restaurant restaurant);

    void insertOneTable(Table table);

    void changeOneTable(Table table);

    void deleteOneTable(Table table);


}
