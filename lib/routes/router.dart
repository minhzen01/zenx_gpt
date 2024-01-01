import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zenx_chatbot/screen/boarding_screen.dart';
import 'package:zenx_chatbot/screen/splash_screen.dart';
import '../screen/home_screen.dart';
import 'route_name.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.homeScreen:
        {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      case RouteName.splashScreen:
        {
          return CupertinoPageRoute(builder: (context) => const SplashScreen());
        }
      case RouteName.boardingScreen:
        {
          return CupertinoPageRoute(builder: (context) => const BoardingScreen());
        }
      default:
        {
          return CupertinoPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
        }
    }
  }

  static goReplacement(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    if (arguments == null) {
      Navigator.of(context).pushReplacementNamed(routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(
        routeName,
        arguments: arguments,
      );
    }
  }
}
