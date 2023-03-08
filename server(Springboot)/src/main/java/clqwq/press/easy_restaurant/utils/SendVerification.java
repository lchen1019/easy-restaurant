package clqwq.press.easy_restaurant.utils;

import com.github.qcloudsms.SmsSingleSender;
import com.github.qcloudsms.SmsSingleSenderResult;
import com.github.qcloudsms.httpclient.HTTPException;
import org.json.JSONException;

import java.io.IOException;

public class SendVerification {
    private static final int appID = 11111111;
    private static final String appKey = "xxxxxxxxxxxxxxxxxxxxxxxxxxx";

    // 修改手机号码的验证码
    public static boolean changeTeleSend(String verification, String tele) {
        boolean res = true;
        try {
            SmsSingleSender smsSingleSender = new SmsSingleSender(appID, appKey);
            SmsSingleSenderResult result = smsSingleSender.send(0, "86", tele,

            "【大山帮】您正在修改手机号码，验证码为：" + verification + "，5分钟有效，为保障帐户安全，请勿向任何人提供此验证码。", "", "");
            res = (result.result != 1016);
        } catch (HTTPException | JSONException | IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    // 修改密码
    public static boolean changePasswordSend(String verification, String tele) {
        boolean res = true;
        try {
            SmsSingleSender smsSingleSender = new SmsSingleSender(appID, appKey);
            SmsSingleSenderResult result = smsSingleSender.send(0, "86", tele,

                    "【大山帮】您正在修改密码，验证码为："+verification+"分钟内有效！", "", "");
            res = (result.result != 1016);
        } catch (HTTPException | JSONException | IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    // 注册验证码
    public static boolean registerSend(String verification, String tele) {
        boolean res = true;
        try {
            SmsSingleSender smsSingleSender = new SmsSingleSender(appID, appKey);
            SmsSingleSenderResult result = smsSingleSender.send(0, "86", tele,

                    "【大山帮】您正在申请手机注册，验证码为："+verification+"分钟内有效！", "", "");
            res = (result.result != 1016);
        } catch (HTTPException | JSONException | IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    //登录验证码
    public static boolean loginSend(String verification, String tele) {
        boolean res = true;
        try {
            SmsSingleSender smsSingleSender = new SmsSingleSender(appID, appKey);
            SmsSingleSenderResult result = smsSingleSender.send(0, "86", tele,

                    "【大山帮】验证码为："+verification+"，您正在登录，若非本人操作，请勿泄露。", "", "");
            res = (result.result != 1016);
        } catch (HTTPException | JSONException | IOException e) {
            e.printStackTrace();
        }
        return res;
    }

    public static void main(String[] args) {
        System.out.println(SendVerification.loginSend("120321","13114391087"));
    }
}