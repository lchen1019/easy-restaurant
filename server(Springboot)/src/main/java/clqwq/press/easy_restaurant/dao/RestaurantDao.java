package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Cost;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.RestaurantMeta;
import clqwq.press.easy_restaurant.mapper.RestaurantMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class RestaurantDao {
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

    /** 注册插入用户记录 **/
    public void register(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        RestaurantMapper restaurantMapper = sqlSession.getMapper(RestaurantMapper.class);
        System.out.println(restaurant);
        restaurantMapper.register(restaurant);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 获取下一个ID **/
    public String getNextID() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        RestaurantMapper restaurantMapper = sqlSession.getMapper(RestaurantMapper.class);
        String str = restaurantMapper.getNextID();
        sqlSession.commit();
        sqlSession.close();
        int nextID = Integer.parseInt(str.substring(1)) + 1;
        return "R" + nextID;
    }

    /** 获取餐馆的meta信息 **/
    public RestaurantMeta getRestaurantMeta(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        RestaurantMapper restaurantMapper = sqlSession.getMapper(RestaurantMapper.class);
        RestaurantMeta result = restaurantMapper.getRestaurantMeta(restaurant);
        sqlSession.close();
        return result;
    }

    /** 修改位置和点名字等信息 **/
    public void changeRestaurantInfo(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        RestaurantMapper restaurantMapper = sqlSession.getMapper(RestaurantMapper.class);
        restaurantMapper.changeRestaurantInfo(restaurant);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改费用信息 **/
    public void changeRestaurantFee(Cost cost) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        RestaurantMapper restaurantMapper = sqlSession.getMapper(RestaurantMapper.class);
        restaurantMapper.changeRestaurantFee(cost);
        sqlSession.commit();
        sqlSession.close();
    }

}
