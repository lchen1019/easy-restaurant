import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example/dialogs/change_dish.dart';
import 'package:example/dialogs/confirm_dish.dart';
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as flutter;
import 'dart:convert' as convert;

import '../dialogs/add_dish.dart';

const Widget spacer = SizedBox(height: 5.0);

class DishPage extends StatefulWidget {

  var userName;

  DishPage(this.userName);

  @override
  _DishPageState createState() => _DishPageState(userName);
}

class _DishPageState extends State<DishPage> {

  var dishInfo;
  var userName;
  var materialsInfo;
  var materialsForDishes;
  var materialsForDishes_;
  var mID2Index;
  var showIndex;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
        header: PageHeader(
            title: const Text('菜品管理'),
            commandBar: Row(
                children: [
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
                          showIndex = [];
                          for (int i = 0; i < dishInfo.length; i++) {
                            String str = "";
                            var item = dishInfo[i];
                            str += item['did'];
                            str += '&&&';
                            str += item['name'];
                            str += '&&&';
                            str += item['price'].toString();
                            str += '&&&';
                            str += item['comment'] ?? "无";
                            str += '&&&';
                            str += item['taste'];
                            str += '&&&';
                            str += item['sales'].toString();
                            str += '&&&';
                            str += materialsForDishes[i];
                            str += '&&&';
                            if (str.contains(filterText)) {
                              showIndex.add(i);
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
                      onPressed: () { batchImport(context); initState();},
                      child: const Icon(FluentIcons.excel_document)
                  ),
                  Container(width: 20)
                ]
            )
        ),
        bottomBar: const InfoBar(
          title: Text('Tip:'),
          content: Text(
            '你可以点击对应餐桌去管理!',
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: showIndex == null ? 0 : showIndex.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                      child: SizedBox(
                          height: 220,
                          child: Card(
                            child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // 菜品的图片
                                  Expanded(
                                      flex: 12,
                                      child: Row(
                                        children:[
                                          Expanded(
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Image.network(
                                                'http://localhost/resources/dishes/${dishInfo[showIndex[index]]['did']}.${dishInfo[showIndex[index]]['format']}',
                                                width: 150,
                                              ),
                                            ),
                                          ),
                                          // 描述菜品的信息
                                          Expanded(
                                            flex: 8,
                                            child: Row(
                                                children: [
                                                  Padding(
                                                      padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                                                      child: Column(
                                                          children: const [
                                                            Text('编号：'),
                                                            Text('菜名：'),
                                                            Text('价格：'),
                                                            Text('成本：'),
                                                            Text('销量：'),
                                                            Text('口感：'),
                                                            Text('余量：'),
                                                            Text('原材料：'),
                                                            Text('备注：')
                                                          ]
                                                      )
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets.fromLTRB(5, 15, 0, 0),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(dishInfo[showIndex[index]]['did'].toString()),
                                                          Text(dishInfo[showIndex[index]]['name'].toString()),
                                                          Text(dishInfo[showIndex[index]]['price'].toString()),
                                                          Text(dishInfo[showIndex[index]]['cost'].toString()),
                                                          Text(dishInfo[showIndex[index]]['sales'].toString()),
                                                          Text(dishInfo[showIndex[index]]['taste'].toString()),
                                                          Text(dishInfo[showIndex[index]]['remain'].toString()),
                                                          Text(materialsForDishes == null ? "无" : materialsForDishes[showIndex[index]]),
                                                          Text(dishInfo[showIndex[index]]['comment'].toString())
                                                        ],
                                                      )
                                                  )
                                                ]
                                            ),
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

  _DishPageState(this.userName);

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
        // 校验完成，向后端发送请求存储所有信息
        var fileName = location.substring(location.lastIndexOf("/") + 1, location.length);
        var format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
        FormData formdata = FormData.fromMap({
          'rid': userName,
          'type': 1,
          "file": await MultipartFile.fromFile(location, filename:fileName)
        });

        Dio dio = Dio();
        await dio.post<String>(
            "http://localhost:9101/batch",
            data: formdata
        ).then((response) {
          print(response.data);
          var str = response.data;
          if (str == "") {
            showContentDialog_(context, '格式有误');
          } else {
            List<dynamic> dishes = convert.jsonDecode(str!);
            // 逐次调用单个上传接口
            for (int i = 0; i < dishes.length; i++) {
              print(dishes[i]);
              save(context, dishes[i], i);
            }
            initState();
          }
        });
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

  Future<bool> save(BuildContext context, dish, i) async {
    // 校验
    if (dish['name'] == "") {
      showContentDialog_(context, '第${i + 1}行格式有误');
      return false;
    } else if (dish['price']! == null) {
      showContentDialog_(context, '第${i + 1}行格式有误');
      return false;
    } else if (dish['taste'] == "") {
      showContentDialog_(context, '第${i + 1}行格式有误');
      return false;
    } else if (dish['materials_'] == "") {
      showContentDialog_(context, '第${i + 1}行格式有误');
      return false;
    } else if (location == null) {
      showContentDialog_(context, '第${i + 1}行格式有误');
      return false;
    }
    // 校验materials，有两个层面，一个是格式正确，一个是原材料包含在其中
    var materialItem = dish['materials_']!.split(";");
    print(materialItem);
    for (int i = 0; i < materialItem.length; i++) {
      var material = materialItem[i].split(",");
      if (material.length != 2) {
        showContentDialog_(context, '原材料格式不正确');
        showContentDialog_(context, '第${i + 1}行格式有误');
        return false;
      }
      if (mID2Index[material[0]] == null) {
        showContentDialog_(context, '原材料不存在');
        showContentDialog_(context, '第${i + 1}行格式有误');
        return false;
      }
    }
    var fileName = dish['location'].substring(dish['location'].lastIndexOf("/") + 1, dish['location'].length);
    var format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
    // 校验完成，向后端发送请求存储所有信息
    FormData formdata = FormData.fromMap({
      'rid': userName,
      'name': dish['name'],
      'price': dish['price'],
      'taste': dish['taste'],
      'materials': dish['materials_'],
      'comment': dish['comment'],
      'format': format,
      "image": await MultipartFile.fromFile(dish['location'], filename:fileName)
    });

    Dio dio = Dio();
    await dio.post<String>(
        "http://localhost:9101/insertOneDish",
        data: formdata
    ).then((value) =>  {
      showContentDialog_(context, '第${i + 1}行上传成功')
    });
    return true;
  }




  @override
  void initState() {
    void getAllMaterials() {
      // 请求所有原材料
      Dio().request(
          "http://localhost:9101/getAllMaterials",
          data: {
            'rid': userName,
          },
          options: Options(contentType: "application/json", method: 'POST')
      ).then((response) => setState(() {
        materialsInfo = response.data;
        // 生成映射，加快查找速度
        mID2Index = Map();
        for (int i = 0; i < materialsInfo.length; i++) {
          mID2Index[materialsInfo[i]['mid']] = i;
        }
        print(materialsInfo);
        print(mID2Index);
        // 循环得到
        materialsForDishes = [];
        materialsForDishes_ = [];
        for (int i = 0; i < dishInfo.length; i++) {
          String temp = "";
          String temp_ = "";
          for (int j = 0; j < dishInfo[i]['materials'].length; j++) {
            var material = dishInfo[i]['materials'][j];
            print(material);
            var mid = material['mid'];
            print(mid);
            if (j != 0) temp += ",";
            if (j != 0) temp_ += ";";
            temp += materialsInfo[mID2Index[mid]]['name'] + material['total'].toString() + materialsInfo[mID2Index[mid]]['measure'];
            temp_ += mid + "," + material['total'].toString();
          }
          materialsForDishes.add(temp);
          materialsForDishes_.add(temp_);
        }
      }));
    }
    // 请求所有菜品
    Dio().request(
        "http://localhost:9101/getAllDishes",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response)  {
      dishInfo = response.data;
      // 初始化showIndex
      showIndex = [];
      for (int i = 0; i < dishInfo.length; i++) {
        showIndex.add(i);
      }
      getAllMaterials();
    });

  }

  void showContentDialog_(BuildContext context, String msg) async {
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


  void showContentDialog(BuildContext context, String msg, String did) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Tips'),
        content: Text(msg),
        actions: [
          Button(
            child: const Text('删除'),
            onPressed: () {
              confirm(context, did);
              Navigator.pop(context);
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

  void confirm(context, did) {
    Dio().request("http://localhost:9101/deleteOneDish",
        data: {
          'did': did,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((value) {
      initState();
    });
  }

  void delete(context, index) {
    showContentDialog(context, '是否确认删除，删除后将不可恢复', dishInfo[index]['did']);
  }

  void change(index) {
    // 打开修改菜品的对话框
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeDishDialog(dishInfo[index], materialsForDishes_[index], mID2Index, userName);
        }
    ).then((value) => initState());
  }

  // 新增一个菜品
  void add() {
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddDishDialog(mID2Index, userName);
        }
    ).then((value) => initState());
  }


}
