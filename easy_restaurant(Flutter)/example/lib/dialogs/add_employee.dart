import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:dio/dio.dart';




class AddEmployeeDialog extends Dialog {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeSex = FocusNode();
  FocusNode focusNodeLocation = FocusNode();
  FocusNode focusNodeSalary = FocusNode();
  String? name;
  String? sex;
  String? location;
  String? salary;

  var userName;


  AddEmployeeDialog(this.userName, {Key? key}) : super(key: key);

  Future<void> save(BuildContext context) async {
    // 保存输入框的状态
    formKey.currentState?.save();
    // 校验
    if (name == "") {
      _showAlertDialog(context, '请输入姓名');
      return;
    } else if (double.tryParse(salary!) == null) {
      _showAlertDialog(context, '薪水格式不正确');
      return;
    } else if (location == null) {
      _showAlertDialog(context, '请输入住址');
      return;
    } else if (sex != '男' || sex != '女') {
      _showAlertDialog(context, '请输入正确的性别');
      return;
    }
    Dio().request(
        "http://localhost:9101/insertOneEmployee",
        data: {
          'rid': userName,
          'sex': sex == '男' ? 1 : 0,
          'location': location,
          'salary': salary,
          'name': name,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      _showAlertDialog(context, '添加成功');
    });
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
                      height: 400,
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
                                              focusNode: focusNodeSex,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "性别",
                                              ),
                                              onSaved: (v) {
                                                sex = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入性别" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeSex.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeLocation,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "地址",
                                              ),
                                              onSaved: (v) {
                                                location = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入地址" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeLocation.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeSalary,
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "薪水",
                                              ),
                                              onSaved: (v) {
                                                salary = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入薪水" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeSalary.requestFocus();
                                              },
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
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
