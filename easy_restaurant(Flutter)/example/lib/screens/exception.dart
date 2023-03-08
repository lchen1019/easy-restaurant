import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:example/dialogs/change_dish.dart';
import 'package:example/dialogs/confirm_dish.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as flutter;

import '../dialogs/add_dish.dart';

const Widget spacer = SizedBox(height: 5.0);

class ExceptionPage extends StatefulWidget {

  var userName;

  ExceptionPage(this.userName);

  @override
  _ExceptionPageState createState() => _ExceptionPageState(userName);
}

class _ExceptionPageState extends State<ExceptionPage> {

  var userName;
  var exception;
  var exceptionShow;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
        header: PageHeader(
            title: const Text('异常管理'),
            commandBar: Row(
                children: [
                  DropDownButton(
                    leading: const Icon(FluentIcons.align_left),
                    title: const Text('种类'),
                    items: [
                      DropDownButtonItem(
                        title: const Text('全部'),
                        leading: const Icon(FluentIcons.all_apps),
                        onTap: () => setState(() => exceptionShow = exception),
                      ),
                      DropDownButtonItem(
                        title: const Text('成本高于售价'),
                        leading: const Icon(FluentIcons.azure_key_vault),
                        onTap: () => setState(() {
                          // 遍历dishInfo判断状态
                          exceptionShow = [];
                          for (var item in exception) {
                            if (item['type'] == 1) {
                              exceptionShow.add(item);
                            }
                          }
                        }),
                      ),
                      DropDownButtonItem(
                        title: const Text('菜品销量过少'),
                        leading: const Icon(FluentIcons.azure_key_vault),
                        onTap: () => setState(() {
                          // 遍历dishInfo判断状态
                          exceptionShow = [];
                          for (var item in exception) {
                            if (item['type'] == 2) {
                              exceptionShow.add(item);
                            }
                          }
                        }),
                      ),
                      DropDownButtonItem(
                        title: const Text('原材料使用量少'),
                        leading: const Icon(FluentIcons.azure_key_vault),
                        onTap: () => setState(() {
                          // 遍历dishInfo判断状态
                          exceptionShow = [];
                          for (var item in exception) {
                            if (item['type'] == 3) {
                              exceptionShow.add(item);
                            }
                          }
                        }),
                      ),
                      DropDownButtonItem(
                        title: const Text('员工薪水过低'),
                        leading: const Icon(FluentIcons.azure_key_vault),
                        onTap: () => setState(() {
                          // 遍历dishInfo判断状态
                          exceptionShow = [];
                          for (var item in exception) {
                            if (item['type'] == 4) {
                              exceptionShow.add(item);
                            }
                          }
                        }),
                      ),
                    ],
                  )
                ]
            )
        ),
        bottomBar: const InfoBar(
          title: Text('Tip:'),
          content: Text('提供可能因用户误操作导致的异常查询')
        ),
        content: GridView.extent(
          maxCrossAxisExtent: 150,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.only(top: kPageDefaultVerticalPadding),
          children: exceptionShow == null ? [] : (exceptionShow).asMap().entries.map<Widget>((entry) {
            var e = entry.value;
            var index = entry.key;
            return HoverButton(
              onPressed: () {

              },
              cursor: SystemMouseCursors.copy,
              builder: (context, states) {
                return FocusBorder(
                  focused: states.isFocused,
                  child: Tooltip(
                    useMousePosition: false,
                    message: '点击以管理',
                    child: RepaintBoundary(
                      child: AnimatedContainer(
                        duration: FluentTheme.of(context).fasterAnimationDuration,
                        decoration: BoxDecoration(
                          color: ButtonThemeData.uncheckedInputColor(
                            FluentTheme.of(context),
                            states,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(e['id']),
                            Text(getTip(e["type"])),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
    );
  }

  _ExceptionPageState(this.userName);

  String getTip(int tag) {
    switch(tag) {
      case 1: return "成本高于售价";
      case 2: return "菜品销量过少";
      case 3: return "原材料使用过少";
      case 4: return "员工薪水过低";
    }
    return "unKnown";
  }

  @override
  void initState() {
    // 请求所有员工
    Dio().request(
        "http://localhost:9101/getAllException",
        data: {
          'rid': userName,
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) => setState(() {
      exception = response.data;
      exceptionShow = exception;
      print(exception);
    }));

  }



}
