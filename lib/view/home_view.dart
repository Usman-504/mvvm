import 'package:flutter/material.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final userPrefences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Home'),
        actions: [
          InkWell(
            onTap: (){
              userPrefences.remove().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
              child: Icon(Icons.logout)),
        ],
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
