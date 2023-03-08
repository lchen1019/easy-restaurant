package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.EmployeeDao;
import clqwq.press.easy_restaurant.dao.RestaurantDao;
import clqwq.press.easy_restaurant.dao.VerificationDao;
import clqwq.press.easy_restaurant.entity.Employee;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Verification;
import clqwq.press.easy_restaurant.utils.MD5Utils;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;


@RestController
public class UserInfoController {

    @CrossOrigin
    @PostMapping("loginByVerification")
    public Employee loginByVerification(@RequestBody Verification verification) {
        // 登录成功，则返回这个Employee记录
        if(new VerificationDao().checkVerification(verification)) {
            // 获取Employee信息
            Employee employee = new Employee();
            employee.setEid(verification.getTel());
            employee.setPassword("");
            return new EmployeeDao().getEmployee(employee);
        }
        return null;
    }

    @CrossOrigin
    @PostMapping("loginByPassword")
    public Employee loginByPassword(@RequestBody Employee employee) {
        // 登录成功，则返回这个Employee记录
        employee.setPassword(MD5Utils.getMD5(employee.getPassword()));
        System.out.println(employee);
        EmployeeDao employeeDao = new EmployeeDao();
        employee = employeeDao.checkPassword(employee);
        System.out.println(employee);
        employee.setPassword("");
        return employee;
    }

    @CrossOrigin
    @RequestMapping("register")
    public boolean Register(@RequestParam("name") String name, @RequestParam("password") String password, @RequestParam("tel") String tel) {
        // 检查电话号码是否被注册过
        EmployeeDao employeeDao = new EmployeeDao();
        Employee employee = new Employee();
        employee.setEid(tel);
        if(employeeDao.getEmployee(employee) != null) {
            return false;
        }
        // 在restaurant中添加一条记录
        // 获取下一个ID
        RestaurantDao restaurantDao = new RestaurantDao();
        String nextID = restaurantDao.getNextID();
        Restaurant restaurant = new Restaurant();
        restaurant.setRid(nextID);
        restaurant.setName(name);
        restaurant.setAdministrator(tel);
        new RestaurantDao().register(restaurant);
        // 在员工表中新增一个员工，并配置密码和权限
        employee.setRid(nextID);
        employee.setName("管理员");
        employee.setHome("无");
        employee.setSalary(0);
        employee.setBuyer(true);
        employee.setManager(true);
        employee.setServer(true);
        employee.setPassword(MD5Utils.getMD5(password));
        new EmployeeDao().insertOneEmployee(employee);
        return true;
    }

    @CrossOrigin
    @PostMapping("resetPassword")
    public boolean resetPassword(@RequestBody Employee employee) {
        // 判断一下这个用户是否存在
        System.out.println(employee);
        EmployeeDao employeeDao = new EmployeeDao();
        if(employeeDao.getEmployee(employee) == null) {
            return false;
        }
        new EmployeeDao().changePassword(employee);
        return true;
    }
}
