package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Order;
import org.apache.ibatis.annotations.Param;

public interface HaveMapper {

    void deleteRecord(Order order);

    void insertRecord(@Param("oid") String oid, @Param("did") String did, @Param("num") double num);

}
