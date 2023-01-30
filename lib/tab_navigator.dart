import 'package:flutter/material.dart';
import './color_detail_page.dart';
import './colors_list_page.dart';
import './tab_item.dart';
import 'Home_Screens/home_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex = 500}) {
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex = 500}) {
    return { 
      TabNavigatorRoutes.root: (context) => HomePage(
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      // TabNavigatorRoutes.root: (context) => ColorsListPage(
      //       color: Colors.green,
      //       title: tabItem.name,
      //       onPush: (materialIndex) =>
      //           _push(context, materialIndex: materialIndex),
      //     ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: Colors.green,
            title: tabItem.name,
            materialIndex: materialIndex,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {

        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}
