import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';



class ChangeMaterialDialog extends Dialog {

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

  var materialsInfo;
  var location;


  ChangeMaterialDialog(this.materialsInfo, {Key? key}) : super(key: key);


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
                                              initialValue: materialsInfo['name'],
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "??????",
                                              ),
                                              onSaved: (v) {
                                                name = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "???????????????" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //???shift????????????
                                                focusNodeName.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodePrice,
                                              initialValue: materialsInfo['price'].toString(),
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "??????",
                                              ),
                                              onSaved: (v) {
                                                price = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "???????????????" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //???shift????????????
                                                focusNodePrice.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeCost,
                                              initialValue: materialsInfo['measure'].toString(),
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "??????",
                                              ),
                                              onSaved: (v) {
                                                measure = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "???????????????" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //???shift????????????
                                                focusNodeCost.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 35,
                                            child: TextFormField(
                                              focusNode: focusNodeSales,
                                              initialValue: materialsInfo['total'].toString(),
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "??????",
                                              ),
                                              onSaved: (v) {
                                                total = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "???????????????" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //???shift????????????
                                                focusNodeSales.requestFocus();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child:TextFormField(
                                                focusNode: focusNodeComment,
                                                initialValue: materialsInfo['comment'],
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "??????",
                                                ),
                                                onSaved: (v) {
                                                  comment = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "???????????????" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //???shift????????????
                                                  focusNodeComment.requestFocus();
                                                },
                                              )
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              flutter.FilledButton(
                                                  child: const Text('????????????'),
                                                  onPressed: () => choose_logo(context)
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              flutter.FilledButton(
                                                  child: const Text('??????'),
                                                  onPressed: () => save(context)
                                              ),
                                              Container(
                                                width: 40,
                                              ),
                                              flutter.FilledButton(
                                                child: const Text('??????'),
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
    // ????????????????????????
    formKey.currentState?.save();
    // ??????
    print("hhhhhqqqqqqq");
    if (name == "") {
      _showAlertDialog(context, '???????????????');
      return;
    } else if (double.tryParse(price!) == null) {
      _showAlertDialog(context, '?????????????????????');
      return;
    } else if (double.tryParse(total!) == null) {
      _showAlertDialog(context, '?????????????????????');
      return;
    }  else if (measure == "") {
      _showAlertDialog(context, '???????????????');
      return;
    }
    print("hhhhh");
    var fileName;
    var format;
    if (location != null) {
      fileName = location.substring(location.lastIndexOf("/") + 1, location.length);
      format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
    } else {
      format = materialsInfo['format'];
    }
    print(format);
    print("hhhhhaaaaaaa");

    // ??????????????????????????????????????????????????????
    FormData formdata = FormData.fromMap({
      'mid': materialsInfo['mid'],
      'rid': materialsInfo['rid'],
      'total': materialsInfo['total'],
      'name': name,
      'measure': measure,
      'price': double.parse(price!),
      'comment': comment,
      'format': format,
    });

    Dio dio = Dio();
    await dio.post<String>(
        "http://localhost:9101/changeMaterial",
        data: formdata
    ).then((value) => () async {
      if (location != null) {
        print("location");
        // ??????????????????????????????????????????????????????
        FormData formdata = FormData.fromMap({
          'mid': materialsInfo['did'],
          'rid': materialsInfo['rid'],
          'format': format,
          "image": await MultipartFile.fromFile(location, filename:fileName)
        });
        Dio dio = Dio();
        await dio.post<String>(
            "http://localhost:9101/changeMaterialImage",
            data: formdata
        ).then((value) => () {
          _showAlertDialog(context, '????????????');
          Navigator.pop(context);
        });
      } else {
        _showAlertDialog(context, '????????????');
        Navigator.pop(context);
      }
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

  _showAlertDialog(BuildContext context, String msg) {
    //????????????
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //???????????????
    AlertDialog alert = AlertDialog(
      title: const Text("??????"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    //???????????????
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}
