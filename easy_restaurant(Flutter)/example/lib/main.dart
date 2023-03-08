import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:url_strategy/url_strategy.dart';
import 'package:window_manager/window_manager.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:example/index.dart' as index;

const String appTitle = 'Easy Restaurant';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(750, 545));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Easy Restaurant'),
          ),
          body: const LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  //继承StatefulWidget类，表示它是一个有状态的组件
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() =>
      _LoginPageState(); //如果集成StatelessWidget类，这里就该是Widget build(BuildContext context)
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  var loginByPassword = true;
  final Uri register_url = Uri.parse('http://localhost/resources/easy_restaurant/register/register.html');
  final Uri reset_url = Uri.parse('http://localhost/resources/easy_restaurant/find_password/find_password.html');
  var wait = false;
  late Timer _timer;
  int _start = 5;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          if (_start <= 0) {
            wait = false;
            _start = 5;
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //构建UI，写控件的地方
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        body: _buildPageContent(),
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      color: Colors.blue,
      child: ListView(
        children: <Widget>[_buildLoginForm()],
      ),
    );
  }

  Container _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
      color: Colors.blue,
      child: Stack(
        //自由位置的组件
        children: [
          Center(
            child: Container(
                width: 500,
                height: 360,
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(10.0),
                decoration: const BoxDecoration(
                  //白色的圆角方框
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  color: Colors.white,
                ),
                child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, //垂直居中
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: TextFormField(
                            focusNode: focusNodeUserName,
                            initialValue: "13114391087",
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "手机号",
                              icon: Icon(
                                Icons.people,
                                color: Colors.blue,
                              ),
                            ),
                            onSaved: (v) {
                              userName = v;
                            },
                            validator: (v) {
                              return v!.isEmpty ? "请输入用户名" : null;
                            },
                            onFieldSubmitted: (v) {
                              //按shift触发方法
                              focusNodePassword.requestFocus();
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: TextFormField(
                                focusNode: focusNodePassword,
                                initialValue: "@Wl2002914",
                                obscureText: true,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "密码/验证码",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.blue,
                                  ),
                                ),
                                onSaved: (v) {
                                  password = v;
                                },
                                validator: (v) {
                                  return v!.isEmpty ? "请输入密码" : null;
                                },
                                onFieldSubmitted: (v) {
                                  _login();
                                },
                              ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(width: 50),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: !loginByPassword,
                                    onChanged: (value) {
                                      setState(() => { loginByPassword = !value! });
                                    }
                                  ),
                                  const Text('使用验证码登录')
                                ],
                              ),
                            ),
                            Container(width: 50),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                child: Text(
                                  wait ? "${_start}s后重试" : "点击发送验证码",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  startTimer();
                                  setState(() => {wait = true});
                                  // 发送验证码
                                  sendVerification();
                                },
                              ),

                            ),
                          ],
                        )
                      ],
                    ))),
          ),
          Container(
            height: 375,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 360,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0))),
                    ),
                    child: const Text("登录",
                        style: TextStyle(color: Colors.white70, fontSize: 20)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: 100),
                      TextButton(
                        child: const Text(
                          '去注册',
                          style: TextStyle(color: Colors.blue),
                        ),
                        onPressed: () {
                          _launchUrl(register_url);
                        },
                      ),
                      Container(width: 200),
                      TextButton(
                        child: const Text(
                          '忘记密码',
                          style: TextStyle(color: Colors.black45),
                        ),
                        onPressed: () {
                          _launchUrl(reset_url);
                        },
                      ),
                      Container(width: 100)
                    ],
                  ),
                )

              ],
            )
          ),
        ],
      ),
    );
  }

  void sendVerification () {
    formKey.currentState?.save();
    if (userName == "") {
      showContentDialog(context, "请输入手机号登录");
      return;
    }
    Dio().request("http://localhost:9101/sendVerification",
        data: {'tel': userName, 'type': 3},
        options: Options(contentType: "application/x-www-form-urlencoded", method: 'POST')
    );
  }

  _login() async {
    // 调用onSaved函数保存用户名和密码
    formKey.currentState?.save();
    if (userName == "") {
      showContentDialog(context, "请输入手机号登录");
      return;
    }
    if (password == "") {
      showContentDialog(context, "请输入密码后登录");
      return;
    }
    print(loginByPassword);
    // 校验用户名和密码
    var response;
    if (loginByPassword) {
      response = await Dio().request("http://localhost:9101/loginByPassword",
        data: {'eid': userName, 'password': password},
        options: Options(contentType: "application/json", method: 'POST')
      );
    } else {
      response = await Dio().request("http://localhost:9101/loginByVerification",
          data: {'tel': userName, 'code': password, 'type': 3},
          options: Options(contentType: "application/json", method: 'POST')
      );
    }
    if (response.data != null) {
        // 进行页面跳转
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return index.MyApp(response.data);
        }));
    } else {
      showContentDialog(context, "密码或账号错误");
    }
  }

    Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void showContentDialog(BuildContext context, String msg) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => flutter.ContentDialog(
        title: const Text('Delete file permanently?'),
        content: Text(msg),
        actions: [
          flutter.FilledButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }
}
