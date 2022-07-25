import 'package:flutter/material.dart';
import 'package:sorteio/pages/home_page.dart';
import 'package:sorteio/pages/sorteio_simples.dart';
import 'package:sorteio/pages/sorteio_personalizado.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    HomePage.route_name: (context) => HomePage(),
    PageSorteioSimples.route_name: (context) => PageSorteioSimples(),
    PageSorteioPersonalizado.route_name: (context) => PageSorteioPersonalizado(),
  };

  static String initial = HomePage.route_name;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static goToPageSorteioSimples(BuildContext context) {
    Navigator.of(context).pushNamed(PageSorteioSimples.route_name);
  }
  static goToPageSorteioPersonalizado(BuildContext context) {
    Navigator.of(context).pushNamed(PageSorteioPersonalizado.route_name);
  }
}
