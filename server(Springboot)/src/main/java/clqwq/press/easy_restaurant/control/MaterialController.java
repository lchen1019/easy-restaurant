package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.MaterialDao;
import clqwq.press.easy_restaurant.entity.Dish;
import clqwq.press.easy_restaurant.entity.Material;
import clqwq.press.easy_restaurant.entity.Restaurant;
import lombok.SneakyThrows;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

@RestController
public class MaterialController {

    @PostMapping("getAllMaterials")
    public Material[] getAllMaterials(@RequestBody Restaurant restaurant) {
        Material[] materials = new MaterialDao().getAllMaterials(restaurant);
        int count = 0;
        for (Material material : materials) {
            if (material.isValid()) {
                count++;
            }
        }
        Material[] result = new Material[count];
        count = 0;
        for (Material material : materials) {
            if (material.isValid()) {
                result[count++] = material;
            }
        }
        return result;
    }

    @SneakyThrows
    @PostMapping("insertOneMaterial")
    public String insertOneDish(@RequestParam("image") MultipartFile img,
                                @RequestParam("rid") String rid,
                                @RequestParam("name") String name,
                                @RequestParam("price") double price,
                                @RequestParam("total") double total,
                                @RequestParam("comment") String comment,
                                @RequestParam("measure") String measure,
                                @RequestParam("format") String format) {
        Material material = new Material();
        // 获取下一个ID
        String nextID = new MaterialDao().getNextID();
        material.setMid(nextID);
        material.setRid(rid);
        material.setComment(comment);
        material.setTotal(total);
        material.setFormat(format);
        material.setPrice(price);
        material.setName(name);
        material.setMeasure(measure);
        // 将图片保存到指定位置
        File file = new File(Material.LOCATION + nextID + "." + format);
        OutputStream out = new FileOutputStream(file);
        byte[] bytes = img.getBytes();
        out.write(bytes);
        // 向数据库中增加一条记录
        new MaterialDao().insertOneMaterial(material);
        return "hello world";
    }

    @PostMapping("deleteOneMaterial")
    public void deleteMaterial(@RequestBody Material material) {
        System.out.println(material);
        new MaterialDao().deleteMaterial(material);
    }


    @SneakyThrows
    @PostMapping("changeMaterial")
    public String changeMaterial(@RequestParam("mid") String mid,
                                 @RequestParam("rid") String rid,
                                 @RequestParam("name") String name,
                                 @RequestParam("total") double total,
                                 @RequestParam("price") double price,
                                 @RequestParam("comment") String comment,
                                 @RequestParam("measure") String measure,
                                 @RequestParam("format") String format) {
        Material material = new Material();
        material.setMid(mid);
        material.setRid(rid);
        material.setComment(comment);
        material.setFormat(format);
        material.setTotal(total);
        material.setPrice(price);
        material.setMeasure(measure);
        material.setName(name);
        // 更新数据库
        new MaterialDao().changeMaterial(material);
        // 判断是否需要存储图片
        return "hello world";
    }

    @SneakyThrows
    @PostMapping("changeMaterialImage")
    public String changeMaterialImage(@RequestParam("image") MultipartFile img, @Param("mid") String mid, @Param("format") String format) {
        File file = new File(Dish.LOCATION + mid + "." + format);
        OutputStream out = new FileOutputStream(file);
        byte[] bytes = img.getBytes();
        out.write(bytes);
        return "hello world";
    }


}
