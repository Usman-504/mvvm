import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewModel homeViewModel = HomeViewModel();
  @override
  void initState() {
    homeViewModel.fetchMoviesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pushNamed(context, RoutesName.weather);
          },
            child: Icon(Icons.sunny)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text('Home'),
        actions: [
          InkWell(
              onTap: () {
                userPreferences.remove().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: const Icon(Icons.logout)),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, vm, child) {
            switch (vm.moviesList.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              case Status.ERROR:
                return Center(
                  child: Text(vm.moviesList.message.toString()),
                );
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: vm.moviesList.data!.movies!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          width: 50,
                          height: 50,
                          vm.moviesList.data!.movies![index].posterurl.toString(),
                        errorBuilder: (context, error, stackTrace) {
                          return const  Icon(Icons.error, color: Colors.red,);
                        },
                        ),
                        title: Text(vm.moviesList.data!.movies![index].title.toString()),
                        subtitle: Text(vm.moviesList.data!.movies![index].year.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Utils.doubleRating(vm.moviesList.data!.movies![index].ratings!).toString()),
                            const Icon(Icons.star, color: Colors.yellow,)
                          ],
                        ),
                      ),
                    );
                  },
                );
              case null:
                // TODO: Handle this case.
                return Container();
            }
          },
        ),
      ),
    );
  }
}
