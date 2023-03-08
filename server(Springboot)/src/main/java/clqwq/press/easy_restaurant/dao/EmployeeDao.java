package clqwq.press.easy_restaurant.dao;

import clqwq.press.easy_restaurant.entity.Employee;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.mapper.EmployeeMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class EmployeeDao {

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

    /** 获取到所有的employee **/
    public Employee[] getAllEmployee(Restaurant restaurant) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        Employee[] result = mapper.getAllEmployee(restaurant);
        sqlSession.close();
        return result;
    }

    /** 根据电话号码，获取employee **/
    public Employee getEmployee(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        Employee result = mapper.getEmployee(employee);
        sqlSession.close();
        return result;
    }

    /** 插入一条记录 **/
    public void insertOneEmployee(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        mapper.insertOneEmployee(employee);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改密码 **/
    public void changePassword(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        mapper.changePassword(employee);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 检查密码是否正确 **/
    public Employee checkPassword(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        employee = mapper.checkPassword(employee);
        sqlSession.close();
        return employee;
    }

    /** 修改权限 **/
    public void changePermission(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        mapper.changePermission(employee);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 删除用户 **/
    public void deleteEmployee(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        mapper.deleteEmployee(employee);
        sqlSession.commit();
        sqlSession.close();
    }

    /** 修改用户信息，不包括权限 **/
    public void changeEmployee(Employee employee) {
        SqlSession sqlSession = sqlSessionFactory.openSession();
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        mapper.changeEmployee(employee);
        sqlSession.commit();
        sqlSession.close();
    }
}
