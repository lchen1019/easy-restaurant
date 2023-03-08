
import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


class ConfirmMaterialDialog extends Dialog {


  ConfirmMaterialDialog(this.mid, {Key? key}) : super(key: key);
  var mid;

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
                    width: 300,
                    height: 170,
                    decoration: const ShapeDecoration(
                        color: Color(0xFFFFFFFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ))),
                    margin: const EdgeInsets.all(12.0),
                    child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container()
                          ),
                          Expanded(
                              flex: 10,
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("请确认是否删除，删除后将不可恢复"),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              flutter.FilledButton(
                                                  child: const Text("取消"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                              flutter.FilledButton(
                                                  child: const Text("确认"),
                                                  onPressed: () {
                                                    confirm(context);
                                                  }
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child: Container()
                          )
                        ]
                    ),
                  )
                ]
            )
        )
    );
  }

  void confirm(context) {
    Dio().request("http://localhost:9101/deleteOneMaterial",
        data: {
          'mid': mid,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((value) {
      _showAlertDialog(context, "删除成功");
    });
  }

  _showAlertDialog(BuildContext context, String msg) {
    //设置按钮
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
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
