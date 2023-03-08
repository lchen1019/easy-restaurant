package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Verification;
import clqwq.press.easy_restaurant.mapper.RestaurantMapper;
import clqwq.press.easy_restaurant.mapper.VerificationMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class VerificationDao {

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

   /** 添加一条验证码记录 **/
    public void insertVerification(Verification verification) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        VerificationMapper verificationMapper = sqlSession.getMapper(VerificationMapper.class);
        verificationMapper.insertVerification(verification);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 检查验证码是否正确，并校验时间 **/
    public boolean checkVerification(Verification verification) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        VerificationMapper verificationMapper = sqlSession.getMapper(VerificationMapper.class);
        return verificationMapper.checkVerification(verification) != null;
    }

}
