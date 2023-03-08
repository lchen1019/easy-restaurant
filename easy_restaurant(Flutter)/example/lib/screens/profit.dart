import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';

import '../dialogs/change_fee.dart';

const Widget spacer = SizedBox(height: 5.0);

class ProfitPage extends StatefulWidget {

  var employee;

  ProfitPage(this.employee);

  @override
  _ProfitPageState createState() => _ProfitPageState(employee);
}

class _ProfitPageState extends State<ProfitPage> {

  var employee;
  var restaurantMeta;
  var costMeta;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: SizedBox(
                height: 950,
                child: ScaffoldPage.withPadding(
                    header: const PageHeader(
                        title: Text('数据统计')
                    ),
                    bottomBar: const InfoBar(
                      title: Text('Tip:'),
                      content: Text(
                        '统计数据是实时的',
                      ),
                    ),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['score'].toStringAsFixed(2) : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('评分', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalNum'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('评价人次', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            )
                          ],
                        ),
                        Container(height: 20),
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalDish'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总菜数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalMaterial'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总原材料数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalOrder'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总订单数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          restaurantMeta != null ? restaurantMeta['totalTable'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('总餐桌数', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                          ],
                        ),
                        Container(height: 20),
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['utilityBill'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('水电费', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['rent'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('店铺租金', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['other'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('其他费用', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            SizedBox(
                              width: 60,
                              height: 125,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: FilledButton(
                                  child: const Icon(FluentIcons.settings),
                                  onPressed: () { change(); },
                                )
                              )
                            )
                          ],
                        ),
                        Container(height: 20),
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['totalSales'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('营业额', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['totalSalary'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('人工费', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                            Container(width: 20),
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['totalCost'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('成本', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            ),
                          ],
                        ),
                        Container(height: 20),
                        Row(
                          children: [
                            SizedBox(
                                width: 180,
                                height: 125,
                                child: Card(
                                  child: Column(
                                      children: [
                                        Text(
                                          costMeta != null ? costMeta['totalProfit'].toString() : "0",
                                          style: const TextStyle(fontSize: 35, color: Color.fromRGBO(255,91,69,1)),
                                        ),
                                        Container(height: 10),
                                        const Text('预期收益', style: TextStyle(fontSize: 20))
                                      ]
                                  ),
                                )
                            )
                          ],
                        ),
                      ],
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

  _ProfitPageState(this.employee);

  @override
  void initState() {
    print(employee);
    // 请求restaurantMetaData
    Dio().request(
        "http://localhost:9101/getRestaurantMeta",
        data: {
          'rid': employee['rid'],
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      setState(() {
        restaurantMeta = response.data;
        print(response.data);
      });
    });
    // 请求costMetaData
    Dio().request(
        "http://localhost:9101/getCost",
        data: {
          'rid': employee['rid'],
        },
        options: Options(contentType: "application/json", method: 'POST')
    ).then((response) {
      setState(() {
        costMeta = response.data;
        print(response.data);
      });
    });
  }

  void change() {
    // 打开修改菜品的对话框
    showDialog<void>(
        context: context, //BuildContext对象
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ChangeFeeDialog(costMeta);
        }
    ).then((value) => initState());
  }

}
