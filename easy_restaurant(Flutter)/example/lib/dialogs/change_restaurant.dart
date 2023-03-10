import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart' as flutter;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';



class ChangeRestaurantDialog extends Dialog {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode focusNodeName = FocusNode();
  FocusNode focusNodeLocation = FocusNode();
  String? name;
  String? location;

  var restaurantMeta;

  ChangeRestaurantDialog(this.restaurantMeta, {Key? key}) : super(key: key);


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
                                              focusNode: focusNodeName,
                                              initialValue: restaurantMeta['name'],
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
                                              focusNode: focusNodeLocation,
                                              initialValue: restaurantMeta['location'].toString(),
                                              // style: const TextStyle(color: Colors.black),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "??????",
                                              ),
                                              onSaved: (v) {
                                                location = v;
                                              },
                                              validator: (v) {
                                                return v!.isEmpty ? "???????????????" : null;
                                              },
                                              onFieldSubmitted: (v) {
                                                //???shift????????????
                                                focusNodeLocation.requestFocus();
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
    if (name == "") {
      _showAlertDialog(context, '???????????????');
      return;
    } else if (location == "") {
      _showAlertDialog(context, '???????????????');
      return;
    }
    // ??????????????????????????????????????????????????????
    Dio().request("http://localhost:9101/changeRestaurantInfo",
        data: {
          'rid': restaurantMeta['rid'],
          'location': location,
          'name': name,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((value) {
      _showAlertDialog(context, '????????????');
    });
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
