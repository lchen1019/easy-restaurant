import 'package:example/screens/exception.dart';
import 'package:example/screens/order.dart';
import 'package:example/screens/profit.dart';
import 'package:example/screens/settings.dart';
import 'package:example/screens/staff.dart';
import 'package:example/screens/table.dart';
import 'package:example/screens/take_out.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'screens/dish.dart';
import 'screens/home.dart';
import 'screens/materials.dart';
import 'theme.dart';

/*------------ 登录后的主页 ----------------*/

const String appTitle = '    Welcome to Easy Restaurant';

class MyApp extends StatelessWidget {
  var employee;

  MyApp(this.employee, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      builder: (context, _) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp(
          title: appTitle,
          themeMode: appTheme.mode,
          debugShowCheckedModeBanner: false,
          home: MyHomePage(employee),
          color: appTheme.color,
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          theme: ThemeData(
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  var employee;

  MyHomePage(this.employee, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(employee);
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool value = false;

  int index = 0;
  var employee;
  final settingsController = ScrollController();
  final viewKey = GlobalKey();

  _MyHomePageState(this.employee);

  @override
  void initState() {
    windowManager.addListener(this);
    print("==================");
    print(employee);
    print("==================");
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        title: () {
          if (kIsWeb) return const Text(appTitle);
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            ),
          );
        }(),
        actions: kIsWeb
            ? null
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [Spacer(), WindowButtons()],
              ),
      ),
      // 左侧导航栏内容面板
      pane: NavigationPane(
        selected: index,
        onChanged: (i) => setState(() => index = i),
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        header: Container(
          height: kOneLineTileHeight,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: FlutterLogo(
            style: appTheme.displayMode == PaneDisplayMode.top
                ? FlutterLogoStyle.markOnly
                : FlutterLogoStyle.horizontal,
            size: appTheme.displayMode == PaneDisplayMode.top ? 24 : 100.0,
          ),
        ),
        displayMode: appTheme.displayMode,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
            default:
              return const StickyNavigationIndicator();
          }
        }(),
        items: getItem(),
        // autoSuggestBox: AutoSuggestBox(
        //   controller: TextEditingController(),
        //   items: const ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
        // ),
        // autoSuggestBoxReplacement: const Icon(FluentIcons.search),
        // 尾部设置页面
        footerItems: [
          PaneItemSeparator(),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('设置'),
          )
        ],
      ),
      // 对应导航栏中每一项的页面
      content: NavigationBody(index: index, children: getPage()),
    );
  }

  getPage() {
    List<Widget> ans = [HomePage(employee)];
    if (employee['buyer']) {
      ans.add(DishPage(employee['rid']));
      ans.add(MaterialsPage(employee['rid']));
    }
    if (employee['server']) {
      ans.add(OrderPage(employee['rid']));
      ans.add(TablePage(employee['rid']));
      ans.add(TakeOutPage(employee['rid']));
    }
    if (employee['manager']) {
      ans.add(StaffPage(employee['rid']));
      ans.add(ProfitPage(employee));
      ans.add(ExceptionPage(employee['rid']));
    }
    ans.add(Settings());
    return ans;
  }

  getItem() {
    List<NavigationPaneItem> ans = [PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('首页'),
    )];
    if (employee['buyer'] || employee['server'] || employee['manager']) {
      ans.add(PaneItemSeparator());
    }
    if (employee['buyer']) {
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.breakfast),
        title: const Text('菜品管理'),
      ));
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.calories),
        title: const Text('原材料管理'),
      ));
      if (employee['server'] || employee['manager']) {
       ans.add(PaneItemSeparator());
      }
    }
    if (employee['server']) {
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.activate_orders),
        title: const Text('订单管理'),
      ));
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.insights),
        title: const Text('餐桌及堂食管理'),
      ));
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.out_of_office),
        title: const Text('外卖管理'),
      ));
      if (employee['manager']) {
        ans.add(PaneItemSeparator());
      }
    }
    if (employee['manager']) {
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.employee_self_service),
        title: const Text('职工及权限管理'),
      ));
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.upgrade_analysis),
        title: const Text('数据统计'),
      ));
      ans.add(PaneItem(
        icon: const Icon(FluentIcons.error),
        title: const Text('异常管理'),
      ));
    }
    return ans;
  }

  @override
  void onWindowClose() async {
    bool _isPreventClose = await windowManager.isPreventClose();
    if (_isPreventClose) {
      showDialog(
        context: context,
        builder: (_) {
          return ContentDialog(
            title: const Text('Confirm close'),
            content: const Text('Are you sure you want to close this window?'),
            actions: [
              FilledButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context);
                  windowManager.destroy();
                },
              ),
              Button(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}