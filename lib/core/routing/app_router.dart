import 'package:chat_app/core/routing/routes.dart';
import 'package:chat_app/features/chat/ui/chat_page.dart';
import 'package:chat_app/features/login/ui/login_page.dart';
import 'package:chat_app/features/register/ui/signup_page.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case Routes.chatPage:
        return MaterialPageRoute(builder: (_) => ChatPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No Route defiend For ${settings.name}'),
                  ),
                ));
    }
  }
}
