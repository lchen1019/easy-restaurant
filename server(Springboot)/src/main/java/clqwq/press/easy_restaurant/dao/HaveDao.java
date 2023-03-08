package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.*;
import clqwq.press.easy_restaurant.entity.Exception;
import clqwq.press.easy_restaurant.mapper.HaveMapper;
import clqwq.press.easy_restaurant.mapper.MaterialMapper;
import clqwq.press.easy_restaurant.mapper.OrderMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class HaveDao {
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

    /** 维持JSON和have表的一致性 **/
    public boolean consistency(DineInOrder order, boolean isInsert) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        HaveMapper mapper = sqlSession.getMapper(HaveMapper.class);
        // 删除原先的记录
        mapper.deleteRecord(order);
        // 新增记录
        SimpleDish[] dishes = order.getDishes();
        for (SimpleDish dish : dishes) {
            mapper.insertRecord(order.getOid(), dish.getDid(), dish.getNum());
        }
        // 插入订单
        OrderMapper orderMapper = sqlSession.getMapper(OrderMapper.class);
        if (isInsert) {
            orderMapper.insertOneDineInOrder(order);
        } else {
            orderMapper.changeDineInOrder(order);
        }
        // 检查原材料的余量是否出现负数，如果出现就进行回滚
        MaterialMapper materialMapper = sqlSession.getMapper(MaterialMapper.class);
        double remain = materialMapper.checkMaterial(order.getRid());
        if (remain < 0) {
            sqlSession.rollback();
            sqlSession.close();
            return false;
        }
        // 提交事务
        sqlSession.commit();
        sqlSession.close();
        return true;
    }
}
