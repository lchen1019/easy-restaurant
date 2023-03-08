package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Table;
import clqwq.press.easy_restaurant.mapper.TableMapper;
import lombok.Data;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class TableDao {

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

    /** 获取到这个restaurant所有的餐桌信息 **/
    public Table[] getAllTable(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        TableMapper tableMapper = sqlSession.getMapper(TableMapper.class);
        System.out.println(restaurant);
        Table[] result = tableMapper.getAllTable(restaurant);
        sqlSession.close();
        return result;
    }

    /** 新增一个餐桌 **/
    public void insertOneTable(Table table) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        TableMapper tableMapper = sqlSession.getMapper(TableMapper.class);
        tableMapper.insertOneTable(table);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 删除一个记录 **/
    public void changeOneTable(Table table) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        TableMapper tableMapper = sqlSession.getMapper(TableMapper.class);
        tableMapper.deleteOneTable(table);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改一个记录 **/
    public void deleteOneTable(Table table) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        TableMapper tableMapper = sqlSession.getMapper(TableMapper.class);
        tableMapper.changeOneTable(table);
        sqlSession.commit();
        sqlSession.close();
    }


}
