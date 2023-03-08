package clqwq.press.easy_restaurant.control;

import clqwq.press.easy_restaurant.dao.VerificationDao;
import clqwq.press.easy_restaurant.entity.Restaurant;
import clqwq.press.easy_restaurant.entity.Verification;
import clqwq.press.easy_restaurant.utils.SendVerification;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Random;

@RestController
public class VerificationController {

    // 解决CROS
    @CrossOrigin
    @RequestMapping("sendVerification")
    public boolean sendVerification(HttpServletRequest request) {
        String tel = request.getParameter("tel");
        System.out.println(tel);
        int type = Integer.parseInt(request.getParameter("type"));
        // 根据type发送验证码
        int code = send(tel, type);
        // 在数据库中增加一条记录
        Verification verification = new Verification();
        verification.setTel(tel);
        verification.setCode(code);
        verification.setType(type);
        System.out.println(verification);
        new VerificationDao().insertVerification(verification);
        return true;
    }

    @CrossOrigin
    @PostMapping("checkVerification")
    @ResponseBody
    public boolean checkVerification(@RequestBody Verification verification) {
        System.out.println(verification.toString());
        return new VerificationDao().checkVerification(verification);
    }

    public int send(String tel, int type) {
        // 随机生成6位数字的二维码
        Random random = new Random();
        int number = 0;
        while (number < 100000) {
            number = number * 10 + random.nextInt(10);
        }
        switch (type) {
            case Verification.LOGIN:
                SendVerification.loginSend(number+"", tel);
                break;
            case Verification.REGISTER:
                SendVerification.registerSend(number+"", tel);
                break;
            case Verification.RESET_PASSWORD:
                SendVerification.changePasswordSend(number+"", tel);
                break;
        }
        return number;
    }
}
