package clqwq.press.easy_restaurant.mapper;

import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Verification;
import org.apache.ibatis.annotations.Param;

public interface VerificationMapper {

    /** 添加一条验证码记录 **/
    void insertVerification(Verification verification);

    /** 获取用户，5mins以内所有type正确的验证码 **/
    Verification checkVerification(Verification verification);
}
