import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:file_picker_desktop/file_picker_desktop.dart';
import 'package:dio/dio.dart';




class AddDishDialog extends Dialog {

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

  var materialsInfo;
  var rid;
  var location;


  AddDishDialog(this.materialsInfo, this.rid, {Key? key}) : super(key: key);

  Future<void> save(BuildContext context) async {
    // 保存输入框的状态
    formKey.currentState?.save();
    // 校验
    if (name == "") {
      print("hhhhh");
      _showAlertDialog(context, '请输入菜名');
      return;
    } else if (double.tryParse(price!) == null) {
      _showAlertDialog(context, '价格格式不正确');
      return;
    } else if (taste == "") {
      _showAlertDialog(context, '请输入口感');
      return;
    } else if (materials == "") {
      _showAlertDialog(context, '请输入原材料');
      return;
    } else if (location == null) {
      _showAlertDialog(context, '请选择图片');
      return;
    }
    print('asdasd');
    // 校验materials，有两个层面，一个是格式正确，一个是原材料包含在其中
    var materialItem = materials!.split(";");
    for (int i = 0; i < materialItem.length; i++) {
      var material = materialItem[i].split(",");
      if (material.length != 2) {
        _showAlertDialog(context, '原材料格式不正确');
        return;
      }
      if (materialsInfo[material[0]] == null) {
        _showAlertDialog(context, '原材料不存在');
        return;
      }
    }
    print(location);
    var start = 0;
    for (int i = location.length - 1; i >= 0; i--) {
      if (location[i] == '.') {
        start = i;
      }
    }
    var fileName = location.substring(location.lastIndexOf("/") + 1, location.length);
    var format = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length);
    // 校验完成，向后端发送请求存储所有信息
    FormData formdata = FormData.fromMap({
      'rid': rid,
      'name': name,
      'price': double.parse(price!),
      'taste': taste,
      'materials': materials,
      'comment': comment,
      'format': format,
      "image": await MultipartFile.fromFile(location, filename:fileName)
    });

    Dio dio = Dio();
    await dio.post<String>(
        "http://localhost:9101/insertOneDish",
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
                                                labelText: "菜名",
                                              ),
                                              onSaved: (v) {
                                                name = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "请输入菜名" : null;
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
                                                focusNode: focusNodeTaste,
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "口感",
                                                ),
                                                onSaved: (v) {
                                                  taste = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "请输入口感" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //按shift触发方法
                                                  focusNodeTaste.requestFocus();
                                                },
                                              )
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child:TextFormField(
                                                focusNode: focusNodeMaterials,
                                                // style: const TextStyle(color: Colors.black),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "原材料",
                                                ),
                                                onSaved: (v) {
                                                  materials = v;
                                                },
                                                validator: (v) {
                                                  return v!.isEmpty ? "请输入原材料" : null;
                                                },
                                                onFieldSubmitted: (v) {
                                                  //按shift触发方法
                                                  focusNodeMaterials.requestFocus();
                                                },
                                              )
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
