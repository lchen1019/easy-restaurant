package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Cost;
import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.mapper.CostMapper;
import clqwq.press.easy_restaurant.mapper.DishMapper;
import com.google.gson.Gson;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Objects;

public class CostDao {

    private static SqlSessionFactory sqlSessionFactory;

    /** 获取到SQLSession工厂，只需要获取一次 **/
    static {
        String resource = "mybatis-config.xml";
        InputStream inputStream = null;
        try {
            inputStream = Resources.getResourceAsStream(resource);
        } catch (IOException e) {
            e.printStackTrace();
        }
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
    }

    /** 获取所有的菜品 **/
    public Cost getCost(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        CostMapper mapper = sqlSession.getMapper(CostMapper.class);
        Cost cost = mapper.getCost(restaurant);
        sqlSession.close();
        return cost;
    }


}
