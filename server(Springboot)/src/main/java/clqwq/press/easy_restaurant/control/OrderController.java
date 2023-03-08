package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.HaveDao;
import clqwq.press.easy_restaurant.dao.OrderDao;
import clqwq.press.easy_restaurant.entity.*;
import com.google.gson.Gson;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class OrderController {

    @PostMapping("getAllDineInOrders")
    public DineInOrder[] getAllDineInOrders(@RequestBody Restaurant restaurant) {
        System.out.println(restaurant);
        return new OrderDao().getAllDineInOrders(restaurant);
    }

    @PostMapping("getAllTakeOutOrders")
    public TakeoutOrder[] getAllTakeOutOrders(@RequestBody Restaurant restaurant) {
        System.out.println(restaurant);
        return new OrderDao().getAllTakeOutOrders(restaurant);
    }

    @PostMapping("changDineInOrderState")
    public void changDineInOrderState(@RequestBody Order order) {
        new OrderDao().changeDineInState(order);
    }

    @PostMapping("changTakeOutOrderState")
    public void changTakeOutOrderState(@RequestBody Order order) {
        System.out.println(order);
        new OrderDao().changeTakeOutState(order);
    }

    @PostMapping("getDiningOrder")
    public Order[] getDiningOrder(@RequestBody Table table) {
        return new OrderDao().getDiningOrder(table);
    }

    @PostMapping("changeDineInOrder")
    public boolean changeDineInOrder(@RequestBody DineInOrder order) {
        Gson gson = new Gson();
        order.setDishes_(gson.toJson(order.getDishes(), SimpleDish[].class));
        // 修改JSON和have表格中的数据
        boolean done = new HaveDao().consistency(order, false);
        return done;
    }

    @PostMapping("insertOneDineInOrder")
    public Order insertOneDineInOrder(@RequestBody DineInOrder order) {
        // 获取下一个ID
        OrderDao dao = new OrderDao();
        String oid = dao.getNextDineInID();
        order.setOid(oid);
        order.setState(1);
        Gson gson = new Gson();
        order.setDishes_(gson.toJson(order.getDishes(), SimpleDish[].class));
        System.out.println(order.getPrice());
        // 修改JSON和have表格中的数据
        boolean done = new HaveDao().consistency(order, true);
        System.out.println(done);
        if (done) {
            return order;
        } else {
            return null;
        }
    }



}
