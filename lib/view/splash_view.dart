import 'package:flutter/material.dart';
import 'package:mvvm/view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});


  @override
  State<SplashView> createState() => _SplashViewState();
}


class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
   splashServices.checkAuthentication(context);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash View'),
      ),
    );
  }
}
