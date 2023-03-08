package clqwq.press.easy_restaurant.entity;

import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

@Data
public class Dish extends Transfer {

    public static final String LOCATION = "D:\\resources\\dishes\\";

    private String did;
    private String rid;
    private String name;
    private double price;
    private String taste;
    private String comment;
    private double cost;
    private int sales;
    private SimpleMaterial[] materials;
    private String format;
    private MultipartFile image;
    private int valid;
    private double remain;
    private String location;

    private String materials_; // 用于简化数据库写入
}
