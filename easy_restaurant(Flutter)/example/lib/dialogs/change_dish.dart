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


class ChangeDishDialog extends Dialog {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodePrice = FocusNode();
  FocusNode focusNodeTaste = FocusNode();
  FocusNode focusNodeMaterials = FocusNode();
  FocusNode focusNodeComment = FocusNode();
  String? name;
  String? price;
  String? taste;
  String? materials;
  String? comment;

  var dish;
  var rid;
  var materialsInfo;
  var materialsForDishes;
  var location;


  ChangeDishDialog(this.dish, this.materialsForDishes,this.materialsInfo, this.rid, {Key? key}) : super(key: key);


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
                                              initialValue: dish['name'],
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
                                              initialValue: dish['price'].toString(),
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
                                                focusNode: focusNodeTaste,
                                                initialValue: dish['taste'],
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "??????",
                                                ),
                                                onSaved: (v) {
                                                  taste = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "???????????????" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //???shift????????????
                                                  focusNodeTaste.requestFocus();
                                                },
                                              )
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child:TextFormField(
                                                focusNode: focusNodeMaterials,
                                                initialValue: materialsForDishes.toString(),
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "?????????",
                                                ),
                                                onSaved: (v) {
                                                  materials = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "??????????????????" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //???shift????????????
                                                  focusNodeMaterials.requestFocus();
                                                },
                                              )
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child:TextFormField(
                                                focusNode: focusNodeComment,
                                                initialValue: dish['comment'],
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
                                                  onPressed: () {
                                                    save(context);
                                                  }
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
    if (name == "") {
      _showAlertDialog(context, '???????????????');
      return;
    } else if (double.tryParse(price!) == null) {
      _showAlertDialog(context, '?????????????????????');
      return;
    } else if (taste == "") {
      _showAlertDialog(context, '???????????????');
      return;
    } else if (materials == "") {
      _showAlertDialog(context, '??????????????????');
      return;
    }
    // ??????materials??????????????????????????????????????????????????????????????????????????????
    var materialItem = materials!.split(";");
    for (int i = 0; i < materialItem.length; i++) {
      var material = materialItem[i].split(",");
      if (material.length != 2) {
        _showAlertDialog(context, '????????????????????????');
        return;
      }
      if (materialsInfo[material[0]] == null) {
        _showAlertDialog(context, '??????????????????');
        return;
      }
    }
    var fileName;
    var format;
    if (location != null) {
      fileName = location.substring(location.lastIndexOf("/") + 1, location.length);
      format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
    } else {
      format = dish['format'];
    }
    // ??????????????????????????????????????????????????????
    FormData formdata = FormData.fromMap({
      'did': dish['did'],
      'rid': rid,
      'name': name,
      'price': double.parse(price!),
      'taste': taste,
      'materials': materials,
      'comment': comment,
      'format': format,
    });

  Dio dio = Dio();
   dio.post(
        "http://localhost:9101/changeDish",
        data: formdata
    ).then((value) async {
      print(location);
      if (location != null) {
        // ??????????????????????????????????????????????????????
        FormData formdata = FormData.fromMap({
          'did': dish['did'],
          'rid': rid,
          'format': format,
          "image": await MultipartFile.fromFile(location, filename:fileName)
        });
        Dio dio = Dio();
        dio.post(
            "http://localhost:9101/changeDish",
            data: formdata
        ).then((value) => () {
          _showAlertDialog(context, '????????????');
        });
      } else {
        _showAlertDialog(context, '????????????');
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
