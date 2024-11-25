import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading =>_loading;

  bool _signUploading = false;
  bool get signUploading =>_signUploading;

  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _signUploading = value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context)async{
setLoading(true);
    _myRepo.loginApi(data).then((value){
      setLoading(false);
      final userPreferences = Provider.of<UserViewModel>(context, listen: false);
      userPreferences.saveUser(UserModel(
        token: ['token'].toString()
      ));
      Utils.snackBar('Login Successful', context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.snackBar(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }


  Future<void> signUpApi(dynamic data, BuildContext context)async{
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);
      Utils.snackBar('SignUp Successful', context);
      Navigator.pushNamed(context, RoutesName.login);
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Utils.snackBar(error.toString(), context);
      if(kDebugMode){
        print(error.toString());
      }
    });
  }

}