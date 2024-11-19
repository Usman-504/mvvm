import 'dart:io';

import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
    }
        on SocketException{
      throw FetchDataException('No Internet Connection');
        }

  }

  @override
  Future getPostApiResponse(String url) {
    // TODO: implement getPostApiResponse
    throw UnimplementedError();
  }
}