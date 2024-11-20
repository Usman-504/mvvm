import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/res/app_urls.dart';

class AuthRepository {

  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.loginEndPoint, data);
      return response;
    }
        catch(e){
      print(e);
      throw e;
        }
  }


  Future<dynamic> signUpApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.registerEndPoint, data);
      return response;
    }
        catch(e){
      print(e);
      throw e;
        }
  }

}