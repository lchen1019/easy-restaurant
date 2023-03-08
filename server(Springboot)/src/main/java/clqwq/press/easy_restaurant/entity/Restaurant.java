package clqwq.press.easy_restaurant.entity;

import lombok.Data;

@Data
public class Restaurant {

  private String rid;
  private String name;
  private String administrator;       // 职工的ID是电话号码
  private String location;
}
