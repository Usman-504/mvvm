import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mvvm/data/app_exceptions.dart';
import 'package:mvvm/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {

  NetworkApiServices._internal();
  static final  NetworkApiServices _instance = NetworkApiServices._internal();
  static NetworkApiServices get instance => _instance;
  // static NetworkApiServices? networkApiServices;
  //
  // NetworkApiServices._internal(){
  //   print('call');
  // }
  //
  // static NetworkApiServices instance(){
  //   networkApiServices ??= NetworkApiServices._internal();
  //   return networkApiServices!;
  // }

  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
   responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic body) async {
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: body).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorizedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error Occurred While Communicating With Server With Status Code${response.statusCode.toString()}');
    }
  }
}
