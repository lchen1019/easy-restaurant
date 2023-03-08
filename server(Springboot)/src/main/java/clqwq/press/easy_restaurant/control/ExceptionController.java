package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.ExceptionDao;
import clqwq.press.easy_restaurant.entity.Exception;
import clqwq.press.easy_restaurant.entity.Restaurant;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ExceptionController {

    @PostMapping("getAllException")
    public Exception[] getAllException(@RequestBody Restaurant restaurant) {
        return new ExceptionDao().getAllException(restaurant);
    }

}
