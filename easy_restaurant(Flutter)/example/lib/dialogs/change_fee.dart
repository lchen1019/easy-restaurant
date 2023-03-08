import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:dio/dio.dart';


class ChangeFeeDialog extends Dialog {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNodeUtilityBill = FocusNode();
  FocusNode focusNodeRent = FocusNode();
  FocusNode focusNodeOther = FocusNode();

  String? utilityBill;
  String? rent;
  String? other;

  var costMeta;



  ChangeFeeDialog(this.costMeta, {Key? key}) : super(key: key);


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
                      width: 400,
                      height: 250,
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
                                              focusNode: focusNodeUtilityBill,
                                              initialValue: costMeta['utilityBill'] == null ? "0" : costMeta['utilityBill'].toString(),

                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "水电费",
                                              ),
                                              onSaved: (v) {
                                                utilityBill = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入水电费" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeUtilityBill.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeRent,
                                              initialValue: costMeta['rent'] == null ? "0" : costMeta['rent'].toString(),
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "店铺租金",
                                              ),
                                              onSaved: (v) {
                                                rent = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入租金" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //按shift触发方法
                                                focusNodeRent.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child: TextFormField(
                                                focusNode: focusNodeOther,
                                                initialValue: costMeta['other'] == null ? "0" : costMeta['other'].toString(),
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "其他费用",
                                                ),
                                                onSaved: (v) {
                                                  other = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "请输入其他费用" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //按shift触发方法
                                                  focusNodeOther.requestFocus();
                                                },
                                              )
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

  Future<void> save(BuildContext context) async {
    // 保存输入框的状态
    formKey.currentState?.save();
    print(costMeta);
    // 校验
    if (double.tryParse(utilityBill!) == null) {
      _showAlertDialog(context, '水电费格式不正确');
      return;
    } else if (double.tryParse(rent!) == null) {
      _showAlertDialog(context, '店铺租金格式不正确');
      return;
    } else if (double.tryParse(other!) == null) {
      _showAlertDialog(context, '其他费用格式不正确');
      return;
    }

    // 校验完成，向后端发送请求存储所有信息
    Dio().request(
        "http://localhost:9101/changeRestaurantFee",
        data: {
          'rid': costMeta['rid'],
          'utilityBill': utilityBill,
          'rent': rent,
          'other': other
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      _showAlertDialog(context, '修改成功');
    });
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
