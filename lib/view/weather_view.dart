import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/weather_model.dart';
import 'package:mvvm/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  WeatherViewModel weatherViewModel = WeatherViewModel();
  @override
  void initState() {
   weatherViewModel.fetchWeatherResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Text('Weather'),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider(
          create: (BuildContext context) => weatherViewModel,
      child: Consumer<WeatherViewModel>(builder: (context, vm, child) {
    switch (vm.weatherData.status) {
      case Status.LOADING:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        );
      case Status.ERROR:
        return Center(
          child: Text(vm.weatherData.message.toString()),
        );
      case Status.COMPLETED:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Humidity: ${vm.weatherData.data!.main!.humidity.toString()}'),
              Text('Pressure: ${vm.weatherData.data!.main!.pressure.toString()}'),
              Text('Sea Level: ${vm.weatherData.data!.main!.seaLevel.toString()}'),
              Text('Speed: ${vm.weatherData.data!.wind!.speed.toString()}'),
            ],
          ),
        );
      case null:
      // TODO: Handle this case.
        return Container();
    }

      },),
      ),
    );
  }
}
