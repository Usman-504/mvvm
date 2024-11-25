import 'package:flutter/material.dart';
import 'package:mvvm/model/weather_model.dart';
import 'package:mvvm/repository/weather_repository.dart';

import '../data/response/api_response.dart';

class WeatherViewModel  with ChangeNotifier{


  final _myRepo = WeatherRepository();

  ApiResponse<WeatherModel> weatherData= ApiResponse.loading();

  setWeatherResponse(ApiResponse<WeatherModel> response){
    weatherData = response;
    notifyListeners();
  }

  Future<void> fetchWeatherResponse () async{
    setWeatherResponse(ApiResponse.loading());
    _myRepo.fetchWeatherData().then((value){
      setWeatherResponse(ApiResponse.completed(value));
    }).onError((error, stackTrace){
      setWeatherResponse(ApiResponse.error(error.toString()));
    });
  }

}