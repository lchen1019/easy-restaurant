package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.mapper.DishMapper;
import clqwq.press.easy_restaurant.mapper.RestaurantMapper;
import com.google.gson.Gson;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Objects;

public class DishDao {

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
    public Dish[] getAllDishes(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        // 解析返回的HashMap键值对
        HashMap<String, String>[] maps = dishMapper.getAllDishes(restaurant);
        Gson gson = new Gson();
        Dish[] dishes = new Dish[maps.length];
        for (int i =0; i < maps.length; i++) {
            HashMap<String, String> map = maps[i];
            System.out.println(map.toString());
            if (Objects.equals(map.get("comment"), "") || map.get("comment") == null) {
                map.put("comment", "无");
            }
            dishes[i] = gson.fromJson(map.toString(), Dish.class);
            System.out.println(dishes[i]);
        }
        sqlSession.close();
        return dishes;
    }

    /** 获取下一个ID **/
    public String getNextID() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        String str = dishMapper.getNextID();
        int nextID = Integer.parseInt(str.substring(1)) + 1;
        sqlSession.close();
        return "D" + nextID;
    }

    /** 插入一条记录 **/
    public void insertOneDish(Dish dish) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        dishMapper.insertOneDish(dish);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改一条记录 **/
    public void changeDish(Dish dish) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        dishMapper.changeDish(dish);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 删除一条记录 **/
    public void deleteDish(Dish dish) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        dishMapper.deleteDish(dish);
        sqlSession.commit();
        sqlSession.close();
    }

}
