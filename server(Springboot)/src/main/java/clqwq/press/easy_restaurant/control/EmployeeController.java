package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.EmployeeDao;
import clqwq.press.easy_restaurant.entity.Employee;
import clqwq.press.easy_restaurant.entity.Restaurant;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;



@RestController
public class EmployeeController {

    @PostMapping("getAllEmployee")
    public Employee[] getAllEmployee(@RequestBody Restaurant restaurant) {
        Employee[] result = new EmployeeDao().getAllEmployee(restaurant);
        for (Employee employee : result) {
            employee.setPassword("");
        }
        return result;
    }

    @PostMapping("changePermission")
    public void changePermission(@RequestBody Employee employee) {
        new EmployeeDao().changePermission(employee);
    }

    @PostMapping("deleteEmployee")
    public void deleteEmployee(@RequestBody Employee employee) {
        System.out.println("================");
        System.out.println(employee);
        System.out.println("================");
        new EmployeeDao().deleteEmployee(employee);
    }

    @PostMapping("insertOneEmployee")
    public void insertOneEmployee(@RequestBody Employee employee) {
        new EmployeeDao().insertOneEmployee(employee);
    }

    @PostMapping("changeEmployee")
    public void changeEmployee(@RequestBody Employee employee) {
        new EmployeeDao().changeEmployee(employee);
    }

}
