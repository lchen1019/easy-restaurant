package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Material;
import clqwq.press.easy_restaurant.entity.Restaurant;
import org.apache.ibatis.annotations.Param;

public interface MaterialMapper {

    Material[] getAllMaterials(Restaurant restaurant);

    String getNextID();

    void insertOneMaterial(Material material);

    void deleteMaterial(Material material);

    void changeMaterial(Material material);

    double checkMaterial(@Param("rid") String rid);

}
