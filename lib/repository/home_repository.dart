import 'package:mvvm/model/movies_model.dart';

import '../data/network/base_api_services.dart';
import '../data/network/network_api_services.dart';
import '../res/app_urls.dart';

class HomeRepository {

  BaseApiServices _apiServices = NetworkApiServices.instance();

  Future<MoviesModel> fetchMovies() async{
    try{
      dynamic response = await _apiServices.getGetApiResponse(AppUrls.moviesListEndPoint);
      return response = MoviesModel.fromJson(response);
    }
    catch(e){
      print(e);
      throw e;
    }
  }
}