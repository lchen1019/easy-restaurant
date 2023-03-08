import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example/dialogs/change_restaurant.dart';
import 'package:fluent_ui/fluent_ui.dart';

const Widget spacer = SizedBox(height: 5.0);

class HomePage extends StatefulWidget {

  var employee;

  HomePage(this.employee);

  @override
  _HomePageState createState() => _HomePageState(employee);
}

class _HomePageState extends State<HomePage> {

  var employee;
  var restaurantMeta;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
                height: 950,
                child: ScaffoldPage.withPadding(
                    header: PageHeader(
                        title: const Text('首页'),
                        commandBar: Row(
                            children: [
                              const Icon(FluentIcons.user_followed),
                              Text(employee['eid']),
                              Container(width: 10),
                              FilledButton(
                                  child: const Icon(FluentIcons.sign_out),
                                  onPressed: () {}
                              ),
                              Container(width: 20)
                            ]
                        )
                    ),
                    bottomBar: const InfoBar(
                      title: Text('Tip:'),
                      content: Text(
                        'Welcome to Easy Restaurant!',
                      ),
                    ),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['score'].toStringAsFixed(2) : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('评分', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalNum'].toString() : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('评价人次', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            )
                          ],
                        ),
                        Container(height: 20),
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalDish'].toString() : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总菜数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalMaterial'].toString() : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总原材料数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalOrder'].toString() : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总订单数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalTable'].toString() : "",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总餐桌数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                          ],
                        ),
                        Container(height: 20),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text("餐馆信息", style: TextStyle(fontSize: 25)),
                        ),
                        Container(height: 5),
                        SizedBox(
                            height: 200,
                            child: Card(
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    // 菜品的图片
                                    Expanded(
                                        flex: 12,
                                        child: Row(
                                          children:[
                                            Padding(
                                                padding: const EdgeInsets.fromLTRB(55, 30, 0, 0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('编号：${restaurantMeta != null ? restaurantMeta['rid'] : ""}', style: const TextStyle(fontSize: 20)),
                                                    Text('名字：${restaurantMeta != null ? restaurantMeta['name'] : ""}', style: const TextStyle(fontSize: 20)),
                                                    Text('位置：${restaurantMeta != null ? restaurantMeta['location'] : ""}', style: const TextStyle(fontSize: 20)),
                                                    Text('电话：${restaurantMeta != null ? restaurantMeta['tel'] : ""}', style: const TextStyle(fontSize: 20)),
                                                  ]
                                                )
                                            )
                                          ],
                                        )
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Align(
                                            alignment: Alignment.topCenter,
                                            child: Row(
                                              children: [
                                                Button(
                                                  onPressed: (){
                                                    // 检查该用户是否有manager权限
                                                    if (employee['manager']) {
                                                      change();
                                                    } else {
                                                      showContentDialog(context, '你没有编辑权限');
                                                    }
                                                  },
                                                  child: const Icon(FluentIcons.settings),
                                                )
                                              ],
                                            )
                                        )
                                    )
                                  ]
                              )
                            )
                        )
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

  _HomePageState(this.employee);

  void change() {
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeRestaurantDialog(restaurantMeta);
        }
    ).then((value) => initState());
  }

  @override
  void initState() {
    print(employee);
    // 请求metaData
    Dio().request(
        "http://localhost:9101/getRestaurantMeta",
        data: {
          'rid': employee['rid'],
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      setState(() {
        restaurantMeta = response.data;
        print(response.data);
      });
    });
  }

  void showContentDialog(BuildContext context, String msg) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Tips'),
        content: Text(msg),
        actions: [
          FilledButton(
            child: const Text('确定'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }


}
