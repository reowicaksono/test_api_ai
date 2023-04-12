import 'package:ai_example/utils/app_routes.dart' as Approute;
import 'package:ai_example/utils/app_constants.dart' as Appconstants;
import 'package:ai_example/views/Home.dart';
import 'package:ai_example/views/chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final data = settings.arguments != null
        ? settings.arguments as Map<String, dynamic>
        : null;
    final RouteSettings? routeSettings = data != null
        ? data[Appconstants.ARGS_ROUTE_SETTINGS] as RouteSettings
        : null;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case Approute.CHAT:
        return MaterialPageRoute(builder: (_) => Chat());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
