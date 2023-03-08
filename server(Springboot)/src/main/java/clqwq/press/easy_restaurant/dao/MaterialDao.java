package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Material;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.mapper.DishMapper;
import clqwq.press.easy_restaurant.mapper.MaterialMapper;
import com.google.gson.Gson;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;

public class MaterialDao {
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

    /** 获取下一个ID **/
    public String getNextID() {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MaterialMapper materialMapper = sqlSession.getMapper(MaterialMapper.class);
        String str = materialMapper.getNextID();
        int nextID = Integer.parseInt(str.substring(1)) + 1;
        sqlSession.close();
        return "M" + nextID;
    }

    /** 获取到所有的material **/
    public Material[] getAllMaterials(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MaterialMapper mapper = sqlSession.getMapper(MaterialMapper.class);
        Material[] result = mapper.getAllMaterials(restaurant);
        sqlSession.close();
        return result;
    }

    /** 插入一条记录 **/
    public void insertOneMaterial(Material material) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MaterialMapper mapper = sqlSession.getMapper(MaterialMapper.class);
        mapper.insertOneMaterial(material);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 删除一条记录 **/
    public void deleteMaterial(Material material) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MaterialMapper mapper = sqlSession.getMapper(MaterialMapper.class);
        mapper.deleteMaterial(material);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改记录 **/
    public void changeMaterial(Material material) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        MaterialMapper mapper = sqlSession.getMapper(MaterialMapper.class);
        mapper.changeMaterial(material);
        sqlSession.commit();
        sqlSession.close();
    }

}
