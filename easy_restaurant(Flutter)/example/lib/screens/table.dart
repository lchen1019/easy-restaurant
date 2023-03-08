import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';


class TablePage extends StatefulWidget {

  var userName;

  TablePage(this.userName);

  @override
  _TablePageState createState() => _TablePageState(userName);
}

class _TablePageState extends State<TablePage> {

  var userName;
  var dishInfo;
  var currentIndex = 0;
  var tableInfo;
  var tableInfoShow;
  var tabs = 1;
  var did2index;

  var tab_index = [0];
  var checked = [false];
  var ordered = [[]];
  var num = [[]];
  var diningOrderInfo = [];
  var editable = [false];

  String filterText = '';
  List<String> selectedContacts = [];


  _TablePageState(this.userName);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
              height: 950,
              child: TabView(
                currentIndex: currentIndex,
                onChanged: (index) => { setState(() => currentIndex = index) },
                tabs: List.generate(tabs, (index) {
                  return Tab(
                    text: Text(index == 0 ? '餐桌管理' : '${tableInfo[tab_index[index]]['tid']}'),
                    closeIcon: FluentIcons.chrome_close,
                    onClosed: () {
                      if (index == 0) {
                        showContentDialog(context, '首页不可关闭');
                        return;
                      }
                      tab_index.removeAt(index);
                      checked.removeAt(index);
                      ordered.removeAt(index);
                      num.removeAt(index);
                      diningOrderInfo.removeAt(index);
                      editable.removeAt(index);
                      setState(() {
                        --tabs;
                        currentIndex -= 1;
                      });
                    }
                  );
                }),
                bodies: List.generate(
                  tabs,
                  (index) => Container(
                    child: index == 0 ? ScaffoldPage.withPadding(
                      header: PageHeader(
                        title: const Text('餐桌管理'),
                        commandBar: Row(
                          children: [
                            DropDownButton(
                              leading: const Icon(FluentIcons.align_left),
                              title: const Text('显示状态'),
                              items: [
                                DropDownButtonItem(
                                  title: const Text('全部'),
                                  leading: const Icon(FluentIcons.all_apps),
                                  onTap: () => setState(() => tableInfoShow = tableInfo),
                                ),
                                DropDownButtonItem(
                                  title: const Text('占用'),
                                  leading: const Icon(FluentIcons.user_clapper),
                                  onTap: () => setState(() {
                                    // 遍历dishInfo判断状态
                                    tableInfoShow = [];
                                    for (var item in tableInfo) {
                                      if (item['state'] == 1) {
                                        tableInfoShow.add(item);
                                      }
                                    }
                                  }),
                                ),
                                DropDownButtonItem(
                                  title: const Text('空闲'),
                                  leading: const Icon(FluentIcons.azure_key_vault),
                                  onTap: () => setState(() {
                                    // 遍历dishInfo判断状态
                                    tableInfoShow = [];
                                    for (var item in tableInfo) {
                                      if (item['state'] == 2) {
                                        tableInfoShow.add(item);
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
                                    tableInfoShow = [];
                                    for (var item in tableInfo) {
                                      String str = "";
                                      str += item['tid'];
                                      str += item['rid'];
                                      str += item['state'] == 1 ? "使用中占用中" : "空闲";
                                      str += ("${item['num']}人桌");
                                      str += item['location'];
                                      if (str.contains(filterText)) {
                                        tableInfoShow.add(item);
                                      }
                                    }
                                  }),
                                ),
                              ),
                            ),
                            Container(width: 10),
                            FilledButton(
                              onPressed: () {},
                              child: const Icon(FluentIcons.add)
                            ),
                          ]
                        )
                      ),
                      bottomBar: const InfoBar(
                        title: Text('Tip:'),
                        content: Text(
                          '你可以点击对应餐桌去管理!',
                        ),
                      ),
                      content: GridView.extent(
                        maxCrossAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.only(top: kPageDefaultVerticalPadding),
                        children: tableInfoShow == null ? [] : (tableInfoShow).asMap().entries.map<Widget>((entry) {
                          var e = entry.value;
                          var index = entry.key;
                          return HoverButton(
                            onPressed: () {
                              tab_index.add(index);
                              checked.add(tableInfo[index]['state'] == 1 ? true : false);
                              editable.add(tableInfo[index]['state'] == 1 ? false : true);
                              // 初始化点餐数组
                              ordered.add([]);
                              num.add([]);
                              for (int i = 0; i < dishInfo.length; i++) {
                                ordered[tabs].add(false);
                                num[tabs].add(0.0);
                              }
                              // 请求这个餐桌上的订单信息
                              if (tableInfo[index]['state'] == 1) {
                                getDiningOrder(tableInfo[index]['tid']);
                              } else {
                                diningOrderInfo.add([]);
                              }
                              setState(() {
                                tabs++;
                                currentIndex = tabs - 1;
                              });
                            },
                            cursor: SystemMouseCursors.copy,
                            builder: (context, states) {
                              return FocusBorder(
                                focused: states.isFocused,
                                child: Tooltip(
                                  useMousePosition: false,
                                  message: '点击以管理',
                                  child: RepaintBoundary(
                                    child: AnimatedContainer(
                                      duration: FluentTheme.of(context).fasterAnimationDuration,
                                      decoration: BoxDecoration(
                                        color: ButtonThemeData.uncheckedInputColor(
                                          FluentTheme.of(context),
                                          states,
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      padding: const EdgeInsets.all(6.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(e["tid"]),
                                          Text("${e["num"]}人桌"),
                                          Text(e["state"] == 1 ? "使用中" : "空闲"),
                                          Text(e["location"]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ) : ScaffoldPage.withPadding(
                      header: const PageHeader(
                          title: Text('餐桌管理')
                      ),
                      content: Column(
                        children: [
                          SizedBox(
                            height: 180,
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 11,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("编号：  ${tableInfo[tab_index[index]]['tid']}"),
                                              Text("人数： ${tableInfo[tab_index[index]]['num']}"),
                                              Text("位置： ${tableInfo[tab_index[index]]['location']}"),
                                              ToggleSwitch(
                                                checked: checked[index],
                                                content: Text(checked[index] ? "使用中" : "空闲"),
                                                onChanged: (bool value) {
                                                  if (!value) {
                                                    // 结束当前订单
                                                    finishOrder(index);
                                                    setState(() {
                                                      checked[index] = !checked[index];
                                                    });
                                                  } else {
                                                    showContentDialog(context, '请提交订单将自动修改');
                                                  }
                                                },
                                              )
                                            ]
                                        ),
                                      )
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Row(
                                        children: [
                                          FilledButton(
                                            onPressed: (){  },
                                            child: const Icon(FluentIcons.settings),
                                          ),
                                          FilledButton(
                                            onPressed: () => deleteTable(tableInfo[tab_index[index]]['tid']),
                                            child: const Icon(FluentIcons.delete),
                                          ),
                                        ],
                                      )
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 15,
                          ),
                          diningOrderInfo[index].length != 1 && checked[index] || diningOrderInfo[index].length != 0 && !checked[index] ? const Text('当前桌子存在异常情况，请检查') :
                          SizedBox(
                            height: 600,
                            child: Card(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Text('订单编号：${diningOrderInfo[index].length == 0 ? '未提交' : diningOrderInfo[index][0]['oid']}'),
                                        ),
                                        const ListTile(
                                          title: Text("选菜"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                          child: SizedBox(
                                            height: 400,
                                            child: ListView.builder(
                                                itemCount: dishInfo.length,
                                                itemBuilder: (context, ind) {
                                                  return ListTile(
                                                    title: Text(dishInfo[ind]['name']),
                                                    subtitle: Text("${dishInfo[ind]['price']}/份"),
                                                    leading: Row(
                                                        children: [
                                                          Checkbox(
                                                            checked: ordered[index][ind],
                                                            onChanged: (bool? value) {
                                                              // 如果不可编辑，就需要提醒切换到编辑模式
                                                              if (!editable[index]) {
                                                                showContentDialog(context, '请切换到编辑模式再修改');
                                                                return;
                                                              }
                                                              setState(() => ordered[index][ind] = value);
                                                            },
                                                          ),
                                                          Image.network("http://localhost/resources/dishes/${dishInfo[ind]['did']}.${dishInfo[ind]['format']}", width: 50,)
                                                        ]
                                                    ),
                                                    trailing: Row(
                                                      children: [
                                                        FilledButton(
                                                            child: const Icon(FluentIcons.chrome_minimize),
                                                            onPressed: () {
                                                              // 如果不可编辑，就需要提醒切换到编辑模式
                                                              if (!editable[index]) {
                                                                showContentDialog(context, '请切换到编辑模式再修改');
                                                                return;
                                                              }
                                                              if (num[index][ind] > 0) {
                                                                setState((){
                                                                  num[index][ind]--;
                                                                });
                                                              }
                                                            }
                                                        ),
                                                        Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: const BoxDecoration(
                                                              color: Color(0x00B7C3),
                                                              borderRadius: BorderRadius.vertical(top: Radius.elliptical(5, 5))
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment.center,
                                                            child: Text("${num[index][ind]}"),
                                                          ),
                                                        ),
                                                        FilledButton(
                                                            child: const Icon(FluentIcons.add),
                                                            onPressed: () {
                                                              // 如果不可编辑，就需要提醒切换到编辑模式
                                                              if (!editable[index]) {
                                                                showContentDialog(context, '请切换到编辑模式再修改');
                                                                return;
                                                              }
                                                              if (num[index][ind] >= 4) {
                                                                showContentDialog(context, '吃不完记得提醒打包');
                                                              }
                                                              setState((){
                                                                num[index][ind]++;
                                                              });
                                                            }
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                            ),
                                          ),
                                        ),
                                        Container(height: 20),
                                        ListTile(
                                          title: Text("合计：  ${calcTotal(index)}元"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                            children: [
                                              FilledButton(
                                                onPressed: (){
                                                  setState(() => {editable[index] = !editable[index]});
                                                  // 如果是保存的话，就需要向后端发送请求保存数据
                                                  if (!editable[index]) {
                                                    saveOrder(index);
                                                  }
                                                },
                                                child: editable[index] ? const Icon(FluentIcons.accept) : const Icon(FluentIcons.edit)
                                              )
                                            ],
                                          )
                                      )
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveOrder(int index) {
    // 根据num与ordered，生成订单的菜项
    var dishes = [];
    for (int i = 0; i < ordered[index].length; i++) {
      var temp = Map();
      if (ordered[index][i]) {
        temp['did'] = dishInfo[i]['did'];
        temp['num'] = num[index][i];
        dishes.add(temp);
      }
    }
    if (checked[index]) {
      Dio().request(
          "http://localhost:9101/changeDineInOrder",
          data: {
            'oid': diningOrderInfo[index][0]['oid'],
            'rid': userName,
            'dishes': dishes,
            'price': calcTotal(index)
          },
          options: Options(contentType: "application/json", method: 'POST')
      ).then((response) => setState(() {
        if (response.data) {
          diningOrderInfo[index][0]['dishes'] = dishes;
          setState(() => initState());
          showContentDialog(context, '已保存');
        } else {
          showContentDialog(context, '订单无法满足');
        }
      }));
    } else {
      Dio().request(
          "http://localhost:9101/insertOneDineInOrder",
          data: {
            'rid': userName,
            'tid': tableInfo[tab_index[index]]['tid'],
            'dishes': dishes,
            'price': calcTotal(index)
          },
          options: Options(contentType: "application/json", method: 'POST')
      ).then((response) => setState(() {
        print(response.data);
        if (response.data != "") {
          diningOrderInfo[index].add(response.data);
          checked[index] = true;
          setState(() => initState());
          showContentDialog(context, '已保存');
        } else {
          showContentDialog(context, '订单无法满足');
        }
      }));
    }
  }

  void deleteTable(var tid) {
    Dio().request(
        "http://localhost:9101/deleteTable",
        data: {
          'tid': tid,
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      showContentDialog(context, '删除陈功');
      initState();
    }));
  }

  double calcTotal(int index) {
    double total = 0.0;
    for (int i = 0; i < dishInfo.length; i++) {
      if (ordered[index][i]) {
        total += num[index][i] * dishInfo[i]['price'];
      }
    }
    return total;
  }
  
  void getDiningOrder(var tid) {
    Dio().request(
        "http://localhost:9101/getDiningOrder",
        data: {
          'tid': tid,
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      if (response.data == "") {
        diningOrderInfo.add([]);
      } else {
        diningOrderInfo.add(response.data);
        // 维护新增的菜品信息
        if (response.data.length != 1) return;
        var dishes = response.data[0]['dishes'];
        for (int i = 0; i < dishes.length; i++) {
          ordered[tabs - 1][did2index[dishes[i]['did']]] = true;
          num[tabs - 1][did2index[dishes[i]['did']]] += dishes[i]['num'];
        }
      }
    }));
  }
  
  void finishOrder(int index) {
    print(diningOrderInfo[index][0]['oid']);
    Dio().request(
        "http://localhost:9101/changDineInOrderState",
        data: {
          'oid': diningOrderInfo[index][0]['oid'],
          'state': 2
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      // 去除
      diningOrderInfo[index] = [];
      initState();
    }));
  }


  @override
  void initState() {
    // 请求所有菜品
    Dio().request(
        "http://localhost:9101/getAllDishes",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      dishInfo = response.data;
      // did2index
      did2index = Map();
      for (int i = 0; i < dishInfo.length; i++) {
        did2index[dishInfo[i]['did']] = i;
      }
      print(did2index);
    }));
    // 请求所有的桌子信息
    Dio().request(
        "http://localhost:9101/getAllTable",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      tableInfo = response.data ;
      tableInfoShow = tableInfo;
      diningOrderInfo.add([]);
    }));

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
