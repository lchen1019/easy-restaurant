package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.CostDao;
import clqwq.press.easy_restaurant.entity.Cost;
import clqwq.press.easy_restaurant.entity.Restaurant;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CostController {

    @PostMapping("getCost")
    public Cost getCost(@RequestBody Restaurant restaurant) {
        return new CostDao().getCost(restaurant);
    }

}
