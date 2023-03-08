import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';


class OrderPage extends StatefulWidget {

  var userName;

  OrderPage(this.userName);

  @override
  _OrderPageState createState() => _OrderPageState(userName);
}

class _OrderPageState extends State<OrderPage> {

  var userName;
  var dishInfo;
  var currentIndex = 0;
  var orderInfo = [];
  var orderInfoShow;
  var checked = [false];
  var state = [ "待接单", "备餐中", "待取餐", "运送中", "已完成"];
  var content;
  var showContent;
  var did2index;

  String filterText = '';


  _OrderPageState(this.userName);

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
                    title: const Text('订单查看'),
                    commandBar: Row(
                        children: [
                          DropDownButton(
                            leading: const Icon(FluentIcons.align_left),
                            title: const Text('种类'),
                            items: [
                              DropDownButtonItem(
                                title: const Text('全部'),
                                leading: const Icon(FluentIcons.all_apps),
                                onTap: () => setState(() => orderInfoShow = orderInfo),
                              ),
                              DropDownButtonItem(
                                title: const Text('外卖'),
                                leading: const Icon(FluentIcons.user_clapper),
                                onTap: () => setState(() {
                                  // 遍历dishInfo判断状态
                                  orderInfoShow = [];
                                  for (var item in orderInfo) {
                                    if (item['tid'] == null) {
                                      orderInfoShow.add(item);
                                    }
                                  }
                                }),
                              ),
                              DropDownButtonItem(
                                title: const Text('堂食'),
                                leading: const Icon(FluentIcons.azure_key_vault),
                                onTap: () => setState(() {
                                  // 遍历dishInfo判断状态
                                  orderInfoShow = [];
                                  for (var item in orderInfo) {
                                    if (item['tid'] != null) {
                                      orderInfoShow.add(item);
                                    }
                                  }
                                }),
                              ),
                            ],
                          ),
                          Container(width: 10),
                          SizedBox(
                            width: 200.0,
                            child: Tooltip(
                              message: 'Filter by name',
                              child: TextBox(
                                suffix: const Icon(FluentIcons.search),
                                placeholder: '输入相关信息以检索',
                                onChanged: (value) => setState(() {
                                  filterText = value;
                                  // 遍历dishInfo判断状态
                                  orderInfoShow = [];
                                  showContent = [];
                                  for (int i = 0; i < orderInfo.length; i++) {
                                    var item = orderInfo[i];
                                    String str = "";
                                    // 外卖订单
                                    if (item['tid'] == null) {
                                      str += item['tel'];
                                      str += "\$";
                                      str += item['oid'];
                                      str += "\$";
                                      str += content[i];
                                      str += "\$";
                                      str += state[item['state']];
                                      str += "\$";
                                      str += item['comment'] ?? "无";
                                      str += "\$";
                                      str += item['score'] == null ? '0' : item['score'].toString();
                                      str += "\$";
                                      str += item['price'].toString();
                                      str += "\$";
                                      str += item['startTime'];
                                      str += "\$";
                                      str += item['location'];
                                    } else {
                                      str += item['tid'];
                                      str += "\$";
                                      str += item['oid'];
                                      str += "\$";
                                      str += content[i];
                                      str += "\$";
                                      str += item['state'] == 1? "就餐中" : "已完成";
                                      str += "\$";
                                      str += item['comment'] ?? "无";
                                      str += "\$";
                                      str += item['score'] == null ? '0' : item['score'].toString();
                                      str += "\$";
                                      str += item['price'].toString();
                                      str += "\$";
                                      str += item['startTime'];
                                    }
                                    if (str.contains(filterText)) {
                                      orderInfoShow.add(item);
                                      showContent.add(content[i]);
                                    }
                                    print(showContent);
                                  }
                                }),
                              ),
                            ),
                          ),
                          Container(width: 10),
                        ]
                    )
                ),
                bottomBar: const InfoBar(
                  title: Text('Tip:'),
                  content: Text(
                    '您可以使用筛选功能快速定位!',
                  ),
                ),
                  content: orderInfoShow == null || orderInfoShow.length == 0?
                  const  Text('未查询到记录') : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: orderInfoShow == null ? 0 : orderInfoShow.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: SizedBox(
                              height: 180,
                              child: orderInfoShow[index]['tid'] == null ?
                              Card(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("外卖订单", style: TextStyle(
                                              color: Colors.blue
                                            )),
                                            Expanded(
                                              flex: 10,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children:[
                                                          // 描述外卖订单的信息
                                                          Padding(
                                                              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                                              child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('编号：${orderInfoShow[index]['oid']}'),
                                                                    Text('顾客电话：${orderInfoShow[index]['tel']}'),
                                                                    Text('总价：${orderInfoShow[index]['price'].toString()}'),
                                                                    Text('下单时间：${orderInfoShow[index]['startTime']}'),
                                                                    Text('评分：${orderInfoShow[index]['score'].toString()}'),
                                                                  ]
                                                              )
                                                          )
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 8,
                                                      child: Row(
                                                        children:[
                                                          // 描述外卖订单的信息
                                                          Padding(
                                                              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                                              child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('地址：${orderInfoShow[index]['location']}'),
                                                                    Text('内容：${showContent[index]}'),
                                                                    Text('备注：${orderInfoShow[index]['comment']}'),
                                                                    Text('状态：${state[orderInfoShow[index]['state']]}'),
                                                                  ]
                                                              )
                                                          )
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                ),) : Card(
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        flex: 20,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("堂食订单", style: TextStyle(
                                                color: Colors.red
                                            )),
                                            Expanded(
                                              flex: 10,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Row(
                                                        children:[
                                                          // 描述外卖订单的信息
                                                          Padding(
                                                              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                                              child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('编号：${orderInfoShow[index]['oid']}'),
                                                                    Text('座位号：${orderInfoShow[index]['tid']}'),
                                                                    Text('总价：${orderInfoShow[index]['price'].toString()}'),
                                                                    Text('下单时间：${orderInfoShow[index]['startTime']}'),
                                                                    Text('评分：${orderInfoShow[index]['score'].toString()}'),
                                                                  ]
                                                              )
                                                          )
                                                        ],
                                                      )
                                                  ),
                                                  Expanded(
                                                      flex: 8,
                                                      child: Row(
                                                        children:[
                                                          // 描述外卖订单的信息
                                                          Padding(
                                                              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                                              child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text('内容：${showContent[index]}'),
                                                                    Text('备注：${orderInfoShow[index]['comment'] ?? "无"}'),
                                                                    Text('状态：${orderInfoShow[index]['state'] == 1 ? "就餐中" : "已完成"}'),
                                                                  ]
                                                              )
                                                          )
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                ),)

                          )
                      );
                    },
                  )
              )
            ),
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    // 请求所有菜品
    void getAllDishes() {
      Dio().request(
          "http://localhost:9101/getAllDishes",
          data: {
            'rid': userName,
          },
          options: Options(contentType: "application/json", method: 'POST')
      ).then((response) => setState(() {
        dishInfo = response.data;
        print('================');
        print(dishInfo);
        print('================');
        // 生成did -> index的映射关系，加快查找速度
        did2index = Map();
        for (int i = 0; i < dishInfo.length; i++) {
          did2index[dishInfo[i]["did"]] = i;
        }
        print(did2index);
        // 处理出所有订单的菜品信息
        content = [];
        for (int i = 0; i < orderInfo.length; i++) {
          String temp = "";
          for (int j = 0; j < orderInfo[i]['dishes'].length; j++) {
            var item = orderInfo[i]['dishes'][j];
            if (j != 0) temp += ",";
            temp += (dishInfo[did2index[item["did"]]]['name'] + ' X ' + item['num'].toString());
          }
          content.add(temp);
        }
        showContent = content;
      }));
    }
    // 请求所有的外卖订单
    Dio().request(
        "http://localhost:9101/getAllTakeOutOrders",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      orderInfo.addAll(response.data);
      orderInfoShow = orderInfo;
      print(orderInfo);
      getAllDishes();
    });
    // 请求所有的堂食订单
    Dio().request(
        "http://localhost:9101/getAllDineInOrders",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      orderInfo.addAll(response.data);
      orderInfoShow = orderInfo;
      print(orderInfo);
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
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }


}
