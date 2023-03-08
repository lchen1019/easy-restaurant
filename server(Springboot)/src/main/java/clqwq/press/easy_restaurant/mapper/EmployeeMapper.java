package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Employee;
import clqwq.press.easy_restaurant.entity.Restaurant;

public interface EmployeeMapper {

    void insertOneEmployee(Employee employee);

    void changeEmployee(Employee employee);

    Employee[] getAllEmployee(Restaurant restaurant);

    Employee getEmployee(Employee employee);

    void changePassword(Employee employee);

    Employee checkPassword(Employee employee);

    void changePermission(Employee employee);

    void deleteEmployee(Employee employee);

}
