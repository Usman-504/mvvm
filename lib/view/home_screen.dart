import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Home'),
      ),
      body:   Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [InkWell(
            onTap: (){
      Navigator.pushNamed(context, RoutesName.login);
      },
        child: const Text(
            'Home Screen',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          ),
          ],
        ),
      ),
    );
  }
}
