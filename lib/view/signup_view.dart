import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../res/colors.dart';
import '../res/components/custom_button.dart';
import '../res/components/custom_textfield.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  final ValueNotifier<bool> _obscurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    _obscurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final heightX = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.blueColor,
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              focusNode: emailFocusNode,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email,
              obscurePassword: _obscurePassword, isPassword: false, current: emailFocusNode, next: passwordFocusNode, labelText: 'Email', hintText: 'Enter Email',
            ),
            SizedBox(
              height: heightX * 0.03,
            ),
            ValueListenableBuilder(
              valueListenable: _obscurePassword,
              builder: (context, value, child) {
                return CustomTextField(
                  focusNode: passwordFocusNode,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  prefixIcon: Icons.lock,
                  obscurePassword: _obscurePassword, isPassword: true, current: passwordFocusNode, next: null, labelText: '', hintText: '',
                );
              },
            ),
            SizedBox(
              height: heightX * 0.03,
            ),
            CustomButton(
                loading: authViewModel.signUploading,
                title: 'Sign Up', onPress: (){
              if(_emailController.text.isEmpty){
                Utils.snackBar('Please Enter Email', context);
              }
              else if(_passwordController.text.isEmpty){
                Utils.snackBar('Please Enter Password', context);
              }
              else if(_passwordController.text.length <6){
                Utils.snackBar('Please Enter 6 Digit Password', context);
              }
              else{
                Map data = {
                  'email' : _emailController.text.trim(),
                  'password' : _passwordController.text.trim(),
                };
                authViewModel.signUpApi(data, context);
                if (kDebugMode) {
                  print('Api Hit');
                }
              }
            }),
            SizedBox(
              height: heightX * 0.03,
            ),
            InkWell(
                onTap: (){
                  Navigator.pushNamed(context, RoutesName.login);
                },
                child: const Text('Already have an account Login Now')),
          ],
        ),
      ),
    );
  }
}
