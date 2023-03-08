import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:dio/dio.dart';




class AddMaterialDialog extends Dialog {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePrice = FocusNode();
  FocusNode focusNodeCost = FocusNode();
  FocusNode focusNodeTaste = FocusNode();
  FocusNode focusNodeSales = FocusNode();
  FocusNode focusNodeMaterials = FocusNode();
  FocusNode focusNodeComment = FocusNode();
  String? name;
  String? price;
  String? measure;
  String? total;
  String? comment;

  var userName;
  var location;


  AddMaterialDialog(this.userName, {Key? key}) : super(key: key);

  Future<void> save(BuildContext context) async {
    // 保存输入框的状态
    formKey.currentState?.save();
    print(name);
    print(price);
    print(total);
    print(comment);
    print(location);
    // 校验
    if (name == "") {
      _showAlertDialog(context, '请输入原材料名');
      return;
    } else if (double.tryParse(price!) == null) {
      print("price");
      _showAlertDialog(context, '价格格式不正确');
      return;
    } else if (double.tryParse(total!) == null) {
      _showAlertDialog(context, '库存格式不正确');
      return;
    } else if (measure == "") {
      _showAlertDialog(context, '请输入单位');
      return;
    } else if (location == null) {
      _showAlertDialog(context, '请选择图片');
      return;
    }
    var fileName = location.substring(location.lastIndexOf("/") + 1, location.length);
    var format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
    // 校验完成，向后端发送请求存储所有信息
    FormData formdata = FormData.fromMap({
      'name': name,
      'price': double.parse(price!),
      'total': double.parse(total!),
      'measure': measure,
      'comment': comment,
      'format': format,
      'rid': userName,
      "image": await MultipartFile.fromFile(location, filename:fileName)
    });

    Dio dio = Dio();
    await dio.post<String>(
        "http://localhost:9101/insertOneMaterial",
        data: formdata
    ).then((value) =>  {
      _showAlertDialog(context, '添加成功')
    });
  }

  Future<void> choose_logo(BuildContext context) async {
    try {
      final result = await pickFiles(
          allowMultiple: false,
          type: FileType.image
      );
      if (result != null) {
        location = result.files.single.path.toString();
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
            type: MaterialType.transparency,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 500,
                      height: 450,
                      decoration: const ShapeDecoration(
                          color: Color(0xFFFFFFFF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ))),
                      margin: const EdgeInsets.all(12.0),
                      child: Form(
                        key: formKey,
                        child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container()
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeName,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "名字",
                                              ),
                                              onSaved: (v) {
                                                name = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入名字" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeName.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodePrice,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "价格",
                                              ),
                                              onSaved: (v) {
                                                price = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入价格" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodePrice.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeCost,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "单位",
                                              ),
                                              onSaved: (v) {
                                                measure = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入单位" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeCost.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeSales,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "库存",
                                              ),
                                              onSaved: (v) {
                                                total = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入库存" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeSales.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child:TextFormField(
                                                focusNode: focusNodeComment,
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "备注",
                                                ),
                                                onSaved: (v) {
                                                  comment = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "请输入备注" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //按shift触发方法
                                                  focusNodeComment.requestFocus();
                                                },
                                              )
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              flutter.FilledButton(
                                                  child: const Text('选择图片'),
                                                  onPressed: () => choose_logo(context)
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              flutter.FilledButton(
                                                  child: const Text('保存'),
                                                  onPressed: () {
                                                    save(context);
                                                  }
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              flutter.FilledButton(
                                                child: const Text('取消'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),
                                        ]
                                    ),
                                  )
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Container()
                              )
                            ]
                        ),
                      )
                  )
                ]
            )
        )
    );
  }

  _showAlertDialog(BuildContext context, String msg) {
    //设置按钮
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //设置对话框
    AlertDialog alert = AlertDialog(
      title: const Text("提示"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}
