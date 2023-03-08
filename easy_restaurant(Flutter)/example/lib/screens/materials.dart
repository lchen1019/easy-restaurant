import 'package:dio/dio.dart';
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:example/dialogs/change_material.dart';
import 'package:example/dialogs/add_material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as flutter;

class MaterialsPage extends StatefulWidget {
  var userName;

  MaterialsPage(this.userName);

  @override
  _MaterialsPageState createState() => _MaterialsPageState(userName);
}

class _MaterialsPageState extends State<MaterialsPage> {

  var materialInfo;
  var userName;
  var showIndex;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
        header: PageHeader(
            title: const Text('原材料管理'),
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
                          showIndex = [];
                          // 遍历MaterialInfo判断状态
                          for (int i = 0; i < materialInfo.length; i++) {
                            var item = materialInfo[i];
                            String str = "";
                            str += item['mid'];
                            str += item['name'];
                            str += item['price'].toString();
                            str += item['measure'];
                            str += item['total'].toString();
                            str += item['comment'] ?? "无";
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
                      onPressed: () => add(),
                      child: const Icon(FluentIcons.add)
                  ),
                  Container(width: 10),
                  FilledButton(
                      onPressed: () => batchImport(context),
                      child: const Icon(FluentIcons.excel_document)
                  ),
                  Container(width: 20),
                ]
            )
        ),
        bottomBar: const InfoBar(
          title: Text('Tip:'),
          content: Text(
            '您可以使用筛选功能快速定位!',
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
                                          Align(
                                            child: Image.network(
                                              'http://localhost/resources/materials/${materialInfo[index]['mid']}.${materialInfo[index]['format']}',
                                              width: 150,
                                            ),
                                          ),
                                          // 描述菜品的信息
                                          Padding(
                                              padding: const EdgeInsets.fromLTRB(55, 30, 0, 0),
                                              child: Column(
                                                  children: const [
                                                    Text('编号：'),
                                                    Text('名字：'),
                                                    Text('成本：'),
                                                    Text('单位：'),
                                                    Text('库存：'),
                                                    Text('余量：'),
                                                    Text('备注：')
                                                  ]
                                              )
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.fromLTRB(15, 30, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(materialInfo[showIndex[index]]['mid'].toString()),
                                                  Text(materialInfo[showIndex[index]]['name'].toString()),
                                                  Text(materialInfo[showIndex[index]]['price'].toString()),
                                                  Text(materialInfo[showIndex[index]]['measure'].toString()),
                                                  Text(materialInfo[showIndex[index]]['total'].toString()),
                                                  Text(materialInfo[showIndex[index]]['remain'].toString()),
                                                  Text(materialInfo[showIndex[index]]['comment']  ?? "无")
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
                                                onPressed: (){change(showIndex[index]);},
                                                child: const Icon(FluentIcons.settings),
                                              ),
                                              Button(
                                                onPressed: (){delete(context, showIndex[index]);},
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

  _MaterialsPageState(this.userName);

  @override
  void initState() {
    // 请求所有原材料
    Dio().request(
        "http://localhost:9101/getAllMaterials",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      materialInfo = response.data;
      showIndex = [];
      for (int i = 0; i < materialInfo.length; i++) {
        showIndex.add(i);
      }
    }));
  }

  void showContentDialog(BuildContext context, String msg, String mid) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Tips'),
        content: Text(msg),
        actions: [
          Button(
            child: const Text('删除'),
            onPressed: () {
              confirm(context, mid);
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

  void confirm(context, mid) {
    Dio().request("http://localhost:9101/deleteOneMaterial",
        data: {
          'mid': mid,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((value) {
      initState();
    });
  }

  void delete(context, index) {
    showContentDialog(context, '是否确认删除，删除后将不可恢复', materialInfo[index]['mid']);
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

  void change(index) {
    // 打开修改菜品的对话框
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeMaterialDialog(materialInfo[index]);
        }
    ).then((value) => initState());
  }

  // 新增一个菜品
  void add() {
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AddMaterialDialog(userName);
        }
    ).then((value) => initState());
  }
}
