import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcare_live/register/register_states.dart';
import '../../../constants/constants.dart';
import 'package:http/http.dart' as http;

import '../home_screen.dart';



class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  // Register
  var registerNameController = TextEditingController();
  var registerEmailController = TextEditingController();
  var registerPasswordController = TextEditingController();
  var registerConfirmPasswordController = TextEditingController();
  var registerPhoneController = TextEditingController();
  var registerFormKey = GlobalKey<FormState>();

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse('$baseUrl2/auth/register');
    final Map<String, dynamic> data ={
      'name': registerNameController.text,
      'email': registerEmailController.text,
      'phone': registerPhoneController.text,
      'gender': gender,
      'password': registerPasswordController.text,
      'password_confirmation': registerConfirmPasswordController.text,
    };
    try {
      final response = await http.post(url, body: jsonEncode(data),
          headers:
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Success signup');
        final jsonResponse = json.decode(response.body);
        authToken = jsonResponse['data']['token'];
        print(authToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        registerNameController.clear();
        registerEmailController.clear();
        registerPhoneController.clear();
        registerPasswordController.clear();
        registerConfirmPasswordController.clear();
      }
      else if (response.statusCode == 403 || response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('This account doesn\'t exist'),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
        print(response.statusCode);
      }
      else if (response.statusCode == 422){
        final jsonResponse = json.decode(response.body);
        print(response.body);
        final managerIdMessage = jsonResponse['message'];
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(managerIdMessage),
            actions: [
              TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                ),
              ),
            ],
          ),
        );
      }
      else {

        print(response.statusCode);
      }
    } catch (error) {
      // Error occurred during the HTTP request
      print('Error: $error');
    }
  }


  // This function is called when the radio is checked or unchecked.
  int groupValue = 0;
  int gender = 0;
  void handleRadioListChanged(value) {
    groupValue = value;
    gender= groupValue-1;
    print(groupValue);
    emit(ChangRadioState());
  }
  bool showError = false;
  void handleTextFieldErrorChanged(value) {
    showError = false;
    emit(ChangTextFieldErrorState());
  }
  void getError() {
    showError = true;
    emit(ChangTextFieldErrorState());
  }

}
