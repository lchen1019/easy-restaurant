package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.*;
import clqwq.press.easy_restaurant.mapper.OrderMapper;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.apache.catalina.mapper.Mapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class OrderDao {
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

    /** 获取所有的堂食订单 **/
    public DineInOrder[] getAllDineInOrders(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        HashMap<String, String>[] maps = mapper.getAllDineInOrders(restaurant);

        DineInOrder[] result = new DineInOrder[maps.length];
        Gson gson = new Gson();
        String[][] keys = {{"start_time", "finish_time"},{"startTime", "finishTime"}};
        for (int i = 0; i < maps.length; i++) {
            result[i] = new DineInOrder();
            HashMap<String, String> map = maps[i];
            for (int j = 0; j < 2; j++) {
                String value = map.get(keys[0][j]);
                map.remove(keys[0][j]);
                map.put(keys[1][j], value);
            }
            System.out.println(map);
            result[i] = gson.fromJson(map.toString(), DineInOrder.class);
        }
        sqlSession.close();
        return result;
    }

    /** 获取所有的外卖订单 **/
    public TakeoutOrder[] getAllTakeOutOrders(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        HashMap<String, String>[] maps = mapper.getAllTakeOutOrders(restaurant);

        TakeoutOrder[] result = new TakeoutOrder[maps.length];
        Gson gson = new Gson();
        String[][] keys = {{"start_time", "finish_time"},{"startTime", "finishTime"}};
        for (int i = 0; i < maps.length; i++) {
            result[i] = new TakeoutOrder();
            HashMap<String, String> map = maps[i];
            for (int j = 0; j < 2; j++) {
                String value = map.get(keys[0][j]);
                map.remove(keys[0][j]);
                map.put(keys[1][j], value);
            }
            System.out.println(map);
            result[i] = gson.fromJson(map.toString(), TakeoutOrder.class);
        }
        sqlSession.close();
        return result;
    }

    /** 修改订单的状态 **/
    public void changeDineInState(Order order) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        mapper.changDineInOrderState(order);
        sqlSession.commit();
        sqlSession.close();
    }

    public void changeTakeOutState(Order order) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        mapper.changTakeOutOrderState(order);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 根据座位号，获取堂食订单中正在使用的那个 **/
    public Order[] getDiningOrder(Table table) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        HashMap<String, String>[] maps = mapper.getDiningOrder(table);
//        Gson gson = new Gson();
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd-HH:mm:ss").create();
        Order[] orders = new Order[maps.length];
        String[][] keys = {{"start_time", "finish_time"},{"startTime", "finishTime"}};
        for (int i = 0; i < orders.length; i++) {
            HashMap<String, String> map = maps[i];
            if (Objects.equals(map.get("comment"), "") || map.get("comment") == null) {
                map.put("comment", "无");
            }
            for (int j = 0; j < 2; j++) {
                String value = map.get(keys[0][j]);
                map.remove(keys[0][j]);
                map.put(keys[1][j], value);
            }
            System.out.println(map.toString());
            map.put("startTime", map.get("startTime") + "");
            orders[i] = gson.fromJson(map.toString(), DineInOrder.class);
        }
        sqlSession.close();
        return orders;
    }


    /** 修改堂食订单的点餐信息和总价格 **/
    public void changeDineInOrder(Order order) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        mapper.changeDineInOrder(order);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 新增堂食订单，对点餐程序和管理程序开放**/
    public void insertOneDineInOrder(DineInOrder dineInOrder) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        mapper.insertOneDineInOrder(dineInOrder);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 获取下一个ID **/
    public String getNextDineInID() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        String str = mapper.getNextDineInID();
        int nextID = Integer.parseInt(str.substring(1)) + 1;
        sqlSession.close();
        return "O" + nextID;
    }

    public String getNextTakeOutID() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
        String str = mapper.getNextTakeOutID();
        int nextID = Integer.parseInt(str.substring(1)) + 1;
        sqlSession.close();
        return "O" + nextID;
    }

    /** 维护JSON和have表之间的一致性 **/
    public void consistency() {

    }
}
