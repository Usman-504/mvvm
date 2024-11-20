import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/home_view.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/signup_view.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (_)=>const HomeView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (_)=>const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (_)=>const SignupView());
      default:
        return MaterialPageRoute(builder: (_){
          return const  Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          );
        });
    }
  }
}