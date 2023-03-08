package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.SimpleMaterial;
import clqwq.press.easy_restaurant.mapper.DishMapper;
import clqwq.press.easy_restaurant.mapper.MakeMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MakeDao {

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

    /** 维护JSON和MAKE表格的一致性 **/
    public String consistency(Dish dish, SimpleMaterial[] materials, boolean isInsert) throws Exception{
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MakeMapper mapper = sqlSession.getMapper(MakeMapper.class);
        // 该事务有四个组成部分
        // 获取下一个ID，这里需要对dish表格加读锁
        String nextID = null;
        if (isInsert) {
            DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
            String str = dishMapper.getNextID();
            int next = Integer.parseInt(str.substring(1)) + 1;
            nextID = "D" + next;
            dish.setDid(nextID);
            System.out.println(dish.getDid());
        }
        // 删除原始记录
        mapper.deleteRecord(dish);
        // 插入记录
        for (SimpleMaterial material : materials) {
            mapper.insertRecord(dish.getDid(), material.getMid(), material.getTotal());
        }
        // 插入或者修改
        DishMapper dishMapper = sqlSession.getMapper(DishMapper.class);
        if (isInsert) {
            dishMapper.insertOneDish(dish);
        } else {
            dishMapper.changeDish(dish);
        }
        // 事务结束
        sqlSession.commit();
        sqlSession.close();
        return nextID;
    }


}
