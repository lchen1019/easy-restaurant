package clqwq.press.easy_restaurant.control;


import clqwq.press.easy_restaurant.dao.TableDao;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Table;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TableController {

    @PostMapping("getAllTable")
    public Table[] getAllTable(@RequestBody Restaurant restaurant) {
        return new TableDao().getAllTable(restaurant);
    }

    @PostMapping("insertOneTable")
    public String insertOneTable(@RequestBody Table table) {
        new TableDao().insertOneTable(table);
        return "hello world";
    }

    @PostMapping("changeOneTable")
    public String changeOneTable(@RequestBody Table table) {
        new TableDao().changeOneTable(table);
        return "hello world";
    }

    @PostMapping("deleteOneTable")
    public String deleteOneTable(@RequestBody Table table) {
        new TableDao().deleteOneTable(table);
        return "hello world";
    }

}
