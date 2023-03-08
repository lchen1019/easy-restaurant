package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.SimpleMaterial;
import org.apache.ibatis.annotations.Param;

public interface MakeMapper {

    void deleteRecord(Dish dish);

    void insertRecord(@Param("did") String did, @Param("mid") String mid, @Param("num")double num);

}
