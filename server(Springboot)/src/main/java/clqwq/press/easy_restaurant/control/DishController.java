package clqwq.press.easy_restaurant.control;


import clqwq.press.easy_restaurant.dao.DishDao;
import clqwq.press.easy_restaurant.dao.MakeDao;
import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.SimpleMaterial;
import com.google.gson.Gson;
import lombok.SneakyThrows;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Arrays;

@RestController
public class DishController {

    @PostMapping("getAllDishes")
    public Dish[] getAllDishes(@RequestBody Restaurant restaurant) {
        Dish[] dishes = new DishDao().getAllDishes(restaurant);
        int count = 0;
        for (Dish dish : dishes) {
            if (dish.getValid() == 1) {
                count++;
            }
        }
        Dish[] result = new Dish[count];
        count = 0;
        for (Dish dish : dishes) {
            if (dish.getValid() == 1) {
                result[count++] = dish;
            }
        }
        System.out.println(Arrays.toString(dishes));
        System.out.println(Arrays.toString(result));
        return result;
    }

    @SneakyThrows
    @PostMapping("insertOneDish")
    public String insertOneDish(@RequestParam("image") MultipartFile img,
                                @RequestParam("rid") String rid,
                                @RequestParam("name") String name,
                                @RequestParam("price") double price,
                                @RequestParam("taste") String taste,
                                @RequestParam("materials") String materials,
                                @RequestParam("comment") String comment,
                                @RequestParam("format") String format) {
        Dish dish = new Dish();
        dish.setRid(rid);
        dish.setComment(comment);
        dish.setTaste(taste);
        dish.setFormat(format);
        dish.setPrice(price);
        dish.setName(name);
        // 解析materials
        String[] str = materials.split(";");
        SimpleMaterial[] simpleMaterials = new SimpleMaterial[str.length];
        for (int i = 0; i < str.length; i++) {
            String[] items = str[i].split(",");
            simpleMaterials[i] = new SimpleMaterial();
            simpleMaterials[i].setMid(items[0]);
            simpleMaterials[i].setTotal(Double.parseDouble(items[1]));
        }
        Gson gson = new Gson();
        dish.setMaterials_(gson.toJson(simpleMaterials));
        System.out.println(dish);
        // 向数据库中增加一条记录，并保持一致性
        String nextID = null;
        while (true) {
            try {
                nextID = new MakeDao().consistency(dish, simpleMaterials, true);
                break;
            } catch (Exception e) {
                System.out.println("rollback");
            }
        }
        // 将图片保存到指定位置
        File file = new File(Dish.LOCATION + nextID + "." + format);
        OutputStream out = new FileOutputStream(file);
        byte[] bytes = img.getBytes();
        out.write(bytes);
        return "hello world";
    }

    @PostMapping("insertDishes")
    public void insertDishes(@RequestBody Dish[] dishes) {

    }

    @PostMapping("deleteOneDish")
    public String deleteOneDish(@RequestBody Dish dish) {
        new DishDao().deleteDish(dish);
        System.out.println("delete");
        return "hello world";
    }

    @SneakyThrows
    @PostMapping("changeDish")
    public String changeDish(@RequestParam("did") String did,
                           @RequestParam("rid") String rid,
                           @RequestParam("name") String name,
                           @RequestParam("price") double price,
                           @RequestParam("taste") String taste,
                           @RequestParam("materials") String materials,
                           @RequestParam("comment") String comment,
                           @RequestParam("format") String format) {
        Dish dish = new Dish();
        dish.setDid(did);
        dish.setRid(rid);
        dish.setComment(comment);
        dish.setTaste(taste);
        dish.setFormat(format);
        dish.setPrice(price);
        dish.setName(name);
        // 解析materials
        String[] str = materials.split(";");
        SimpleMaterial[] simpleMaterials = new SimpleMaterial[str.length];
        for (int i = 0; i < str.length; i++) {
            String[] items = str[i].split(",");
            simpleMaterials[i] = new SimpleMaterial();
            simpleMaterials[i].setMid(items[0]);
            simpleMaterials[i].setTotal(Double.parseDouble(items[1]));
        }
        Gson gson = new Gson();
        System.out.println(dish);
        dish.setMaterials_(gson.toJson(simpleMaterials));
        // 保持一致性
        new MakeDao().consistency(dish, simpleMaterials, false);
        return "hello world";
    }

    @SneakyThrows
    @PostMapping("changeImage")
    public String changeDish(@RequestParam("image") MultipartFile img, @Param("did") String did, @Param("format") String format) {
        // 这里是解决修改菜品的时候图片修改的问题
        File file = new File(Dish.LOCATION + did + "." + format);
        OutputStream out = new FileOutputStream(file);
        byte[] bytes = img.getBytes();
        out.write(bytes);
        return "hello world";
    }


}
