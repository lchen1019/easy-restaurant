import 'package:dio/dio.dart';
import 'package:example/dialogs/add_employee.dart';
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';

import '../dialogs/change_employee.dart';

const Widget spacer = SizedBox(height: 5.0);

class StaffPage extends StatefulWidget {

  var userName;

  StaffPage(this.userName);

  @override
  _StaffPageState createState() => _StaffPageState(userName);
}

class _StaffPageState extends State<StaffPage> {

  var employeeInfo;
  var employeeShowInfo;
  var userName;
  var materialsInfo;
  var materialsForDishes;
  var materialsForDishes_;
  var mID2Index;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: PageHeader(
          title: const Text('员工管理'),
          commandBar: Row(
              children: [
                DropDownButton(
                  leading: const Icon(FluentIcons.align_left),
                  title: const Text('性别'),
                  items: [
                    DropDownButtonItem(
                      title: const Text('全部'),
                      leading: const Icon(FluentIcons.all_apps),
                      onTap: () => setState(() => employeeShowInfo = employeeInfo),
                    ),
                    DropDownButtonItem(
                      title: const Text('男'),
                      leading: const Icon(FluentIcons.user_clapper),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (item['sex']) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                    DropDownButtonItem(
                      title: const Text('女'),
                      leading: const Icon(FluentIcons.azure_key_vault),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (!item['sex']) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                  ],
                ),
                DropDownButton(
                  leading: const Icon(FluentIcons.align_left),
                  title: const Text('薪资范围'),
                  items: [
                    DropDownButtonItem(
                      title: const Text('全部'),
                      leading: const Icon(FluentIcons.all_apps),
                      onTap: () => setState(() => employeeShowInfo = employeeInfo),
                    ),
                    DropDownButtonItem(
                      title: const Text('<=3000'),
                      leading: const Icon(FluentIcons.user_clapper),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (item['salary'] <= 3000) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                    DropDownButtonItem(
                      title: const Text('3000-5000'),
                      leading: const Icon(FluentIcons.user_clapper),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (item['salary'] > 3000 && item['salary'] <= 5000) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                    DropDownButtonItem(
                      title: const Text('5000-7000'),
                      leading: const Icon(FluentIcons.azure_key_vault),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (item['salary'] > 5000 && item['salary'] <= 7000) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                    DropDownButtonItem(
                      title: const Text('>7000'),
                      leading: const Icon(FluentIcons.azure_key_vault),
                      onTap: () => setState(() {
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          if (item['salary'] > 7000) {
                            employeeShowInfo.add(item);
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
                        var filterText = value;
                        // 遍历dishInfo判断状态
                        employeeShowInfo = [];
                        for (var item in employeeInfo) {
                          String str = "";
                          str += item['eid'];
                          str += item['rid'];
                          str += item['sex'] ? "男" : "女";
                          str += item['home'];
                          str += item['name'];
                          str += item['salary'];
                          if (str.contains(filterText)) {
                            employeeShowInfo.add(item);
                          }
                        }
                      }),
                    ),
                  ),
                ),
                Container(width: 10),
                FilledButton(
                    onPressed: () { add(); },
                    child: const Icon(FluentIcons.add)
                ),
                Container(width: 10),
                FilledButton(
                    onPressed: () { batchImport(context); },
                    child: const Icon(FluentIcons.excel_document)
                )
              ]
          )
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: employeeShowInfo == null ? 0 : employeeShowInfo.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                    child: SizedBox(
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
                                        // 描述菜品的信息
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                            child: Column(
                                                children: const [
                                                  Text('编号：'),
                                                  Text('姓名：'),
                                                  Text('性别：'),
                                                  Text('地址：'),
                                                  Text('薪水：')
                                                ]
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(employeeShowInfo[index]['eid']),
                                                Text(employeeShowInfo[index]['name']),
                                                Text(employeeShowInfo[index]['sex'] ? '男' : '女'),
                                                Text(employeeShowInfo[index]['home']),
                                                Text('${employeeShowInfo[index]['salary']}元/月')
                                              ],
                                            )
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(90, 30, 0, 0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Text('原材料、菜品管理权限'),
                                                    ToggleSwitch(
                                                        checked: employeeShowInfo[index]['buyer'],
                                                        onChanged: (value) {
                                                          employeeShowInfo[index]['buyer'] = value;
                                                          savePermission(index);
                                                          setState(() {});
                                                        }
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('外卖堂食订单管理权限'),
                                                    ToggleSwitch(
                                                        checked: employeeShowInfo[index]['server'],
                                                        onChanged: (value) {
                                                          employeeShowInfo[index]['server'] = value;
                                                          savePermission(index);
                                                          setState(() {});
                                                        }
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text('员工管理、统计信息查看权限'),
                                                    ToggleSwitch(
                                                        checked: employeeShowInfo[index]['manager'],
                                                        onChanged: (value) {
                                                          employeeShowInfo[index]['manager'] = value;
                                                          savePermission(index);
                                                          setState(() {});
                                                        }
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                        )
                                      ],
                                    )
                                ),
                                Expanded(
                                    flex: 2,
                                    child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Row(
                                          children: [
                                            Button(
                                              onPressed: (){change(index);},
                                              child: const Icon(FluentIcons.settings),
                                            ),
                                            Button(
                                              onPressed: (){delete(context, index);},
                                              child: const Icon(FluentIcons.delete),
                                            ),
                                          ],
                                        )
                                    )
                                )
                              ]
                          ),)
                    )
                );
              },
            )
          ],
        ),
      )
    );
  }

  _StaffPageState(this.userName);

  @override
  void initState() {
    // 请求所有员工
    Dio().request(
        "http://localhost:9101/getAllEmployee",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      employeeInfo = response.data;
      employeeShowInfo = response.data;
      print(employeeInfo);
    }));
  }

  var location; // excel的位置
  Future<void> choose_excel(BuildContext context) async {
    try {
      final result = await pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );
      if (result != null) {
        location = result.files.single.path.toString();
        print(location);
        // 上传excel
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void batchImport(context) {
    choose_excel(context);
  }

  void savePermission(int index) {
    Dio().request(
        "http://localhost:9101/changePermission",
        data: {
          'eid': employeeShowInfo[index]['eid'],
          'manager': employeeShowInfo[index]['manager'],
          'buyer': employeeShowInfo[index]['buyer'],
          'server': employeeShowInfo[index]['server']
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      showContentDialog(context, '修改成功');
    });
  }

  void change(index) {
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeEmployeeDialog(employeeShowInfo[index]);
        }
    ).then((value) => initState());
  }

  void add() {
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddEmployeeDialog(userName);
        }
    ).then((value) => initState());
  }

  void delete(context, index) {
    showContentDialog_(context, '确认是否删除，删除后将不可恢复', index);
  }

  void showContentDialog_(BuildContext context, String msg, int index) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Tips'),
        content: Text(msg),
        actions: [
          Button(
            child: const Text('确认'),
            onPressed: () {
              // 向后端发送请求
              Dio().request(
                  "http://localhost:9101/deleteEmployee",
                  data: {
                    'eid': employeeShowInfo[index]['eid']
                  },
                  options: Options(contentType: "application/json", method: 'POST')
              ).then((response) {
                showContentDialog(context, '修改成功');
                initState();
              });
              Navigator.pop(context, 'User deleted file');
            },
          ),
          FilledButton(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }

  void showContentDialog(BuildContext context, String msg) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Tips'),
        content: Text(msg),
        actions: [
          Button(
            child: const Text('确认'),
            onPressed: () {
              Navigator.pop(context, 'User deleted file');
            },
          ),
          FilledButton(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context, 'User canceled dialog'),
          ),
        ],
      ),
    );
    setState(() {});
  }


}
