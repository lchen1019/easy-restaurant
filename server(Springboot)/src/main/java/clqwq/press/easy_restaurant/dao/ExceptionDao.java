package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Employee;
import clqwq.press.easy_restaurant.entity.Exception;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.mapper.EmployeeMapper;
import clqwq.press.easy_restaurant.mapper.ExceptionMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class ExceptionDao {

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

    /** 获取到所有的exception **/
    public Exception[] getAllException(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        ExceptionMapper exceptionMapper = sqlSession.getMapper(ExceptionMapper.class);
        Exception[] result = exceptionMapper.getAllException(restaurant);
        sqlSession.close();
        return result;
    }

}
