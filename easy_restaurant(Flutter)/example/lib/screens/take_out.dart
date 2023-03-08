import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';


class TakeOutPage extends StatefulWidget {

  var userName;

  TakeOutPage(this.userName);

  @override
  _TakeOutPageState createState() => _TakeOutPageState(userName);
}

class _TakeOutPageState extends State<TakeOutPage> {

  var userName;
  var dishInfo;
  var currentIndex = 0;
  var orderInfo;
  var orderInfoShow;
  var did2index;
  var checked_accepted;
  var checked_maded;
  var state = ["用户已取消", "待接单", "备餐中", "待取餐", "运送中", "已完成"];
  var content;

  String filterText = '';
  List<String> selectedContacts = [];

  var contacts = ['Kendall', 'Collins', 'Kendall', 'Collins', 'Kendall', 'Collins','Kendall', 'Collins'];

  _TakeOutPageState(this.userName);

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
                        title: const Text('外卖管理'),
                        commandBar: Row(
                            children: [
                              DropDownButton(
                                leading: const Icon(FluentIcons.align_left),
                                title: const Text('状态'),
                                items: [
                                  DropDownButtonItem(
                                    title: const Text('全部'),
                                    leading: const Icon(FluentIcons.all_apps),
                                    onTap: () => setState(() => orderInfoShow = orderInfo),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('用户取消'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 0) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('待接单'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 1) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('备餐中'),
                                    leading: const Icon(FluentIcons.azure_key_vault),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 2) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('待取餐'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 3) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('运送中'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 4) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('已完成'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 5) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                ],
                              ),
                              Container(width: 10),
                              DropDownButton(
                                leading: const Icon(FluentIcons.align_left),
                                title: const Text('有效性'),
                                items: [
                                  DropDownButtonItem(
                                    title: const Text('全部'),
                                    leading: const Icon(FluentIcons.all_apps),
                                    onTap: () => setState(() => orderInfoShow = orderInfo),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('有效'),
                                    leading: const Icon(FluentIcons.user_clapper),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] != 0) {
                                          orderInfoShow.add(item);
                                        }
                                      }
                                    }),
                                  ),
                                  DropDownButtonItem(
                                    title: const Text('用户取消'),
                                    leading: const Icon(FluentIcons.azure_key_vault),
                                    onTap: () => setState(() {
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (var item in orderInfo) {
                                        if (item['state'] == 0) {
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
                                      print(filterText);
                                      // 遍历dishInfo判断状态
                                      orderInfoShow = [];
                                      for (int i = 0; i < orderInfo.length; i++) {
                                        var item = orderInfo[i];
                                        String str = "";
                                        str += item['oid'];
                                        str += item['tel'];
                                        int state = item['state'];
                                        switch(state) {
                                          case 0:
                                            str += "用户取消"; break;
                                          case 1:
                                            str += "待接单"; break;
                                          case 2:
                                            str += "备餐中"; break;
                                          case 3:
                                            str += "待取餐"; break;
                                          case 4:
                                            str += "运送中"; break;
                                          case 5:
                                            str += "已完成"; break;
                                        }
                                        str += item['startTime'] ?? "";
                                        str += item['location'] ?? "";
                                        str += item['comment'] ?? "";
                                        str += (item['price'] ?? "").toString();
                                        str += content[i];
                                        if (str.contains(filterText)) {
                                          orderInfoShow.add(item);
                                        }
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
                        '外卖订单管理，提供接单、出餐按钮!',
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
                                height: 230,
                                child: Card(
                            child: Row(
                            mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                                                Text('内容：${content[index]}'),
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
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               ToggleSwitch(
                                                   checked: checked_accepted[index],
                                                   content: Text(checked_accepted[index] ? '已接单' : '待接单'),
                                                   onChanged: (bool value) {
                                                     if (orderInfo[index]['state'] == 0) {
                                                       showContentDialog(context, '用户已取消');
                                                       return;
                                                     }
                                                     if (!value) {
                                                       // 提示已经接单边不允许修改
                                                      showContentDialog(context, '已经接单，不允许退单');
                                                     } else {
                                                       setState((){
                                                         checked_accepted[index] = value;
                                                       });
                                                       // 向后端发送请求，更改状态
                                                       changeState(index);
                                                     }
                                                   }
                                               ),
                                               ToggleSwitch(
                                                   checked: checked_maded[index],
                                                   content: Text(checked_maded[index] ? '备餐完成' : checked_accepted[index] ? '备餐中' :'请先接单'),
                                                   onChanged: (bool value) {
                                                     if (orderInfo[index]['state'] == 0) {
                                                       showContentDialog(context, '用户已取消');
                                                       return;
                                                     }
                                                     if (!value) {
                                                       // 提示已经接单边不允许修改
                                                       showContentDialog(context, '已经出餐，不允许修改');
                                                     } else {
                                                       if (!checked_accepted[index]) {
                                                         showContentDialog(context, '请先接单');
                                                       } else {
                                                         setState((){
                                                           checked_maded[index] = value;
                                                         });
                                                         // 向后端发送请求，更改状态
                                                         changeState(index);
                                                       }
                                                     }
                                                   }
                                               )
                                             ],
                                           ),
                                          )
                                        )
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

  void changeState(int index) {
    Dio().request(
        "http://localhost:9101/changTakeOutOrderState",
        data: {
          'oid': orderInfo[index]['oid'],
          'rid': userName,
          'state': orderInfo[index]['state'] + 1
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      orderInfo[index]['state'] += 1;
    }));
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
        // 生成did -> index的映射关系，加快查找速度
        did2index = Map();
        for (int i = 0; i < dishInfo.length; i++) {
          did2index[dishInfo[i]["did"]] = i;
        }
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
        print(content);
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
      orderInfo = response.data ;
      print(orderInfo);
      orderInfoShow = orderInfo;
      // 初始化checked数组，用于显示订单状态
      checked_accepted = [];
      checked_maded = [];
      for (int i = 0; i < orderInfo.length; i++) {
        checked_accepted.add(orderInfo[i]['state'] > 1);
        checked_maded.add(orderInfo[i]['state'] >= 3);
      }
      getAllDishes();
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
