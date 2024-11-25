import 'package:mvvm/model/weather_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class WeatherRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<WeatherModel> fetchWeatherData() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.weatherEndPoint);
      return response = WeatherModel.fromJson(response);
    }
    catch(e){
      print(e);
      throw e;
    }
  }
}