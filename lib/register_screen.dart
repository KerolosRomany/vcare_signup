import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcare_live/register/register_cubit.dart';
import 'package:vcare_live/register/register_states.dart';

import '../components/screen_size.dart';
import 'components/components.dart';
import 'constants/constants.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context);

    return BlocBuilder<RegisterCubit, RegisterStates>(builder: (context, state) {
      RegisterCubit cubit = RegisterCubit.get(context);
      return Scaffold(
        body: SafeArea(
          child: Form(
            key: cubit.registerFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let’s get started!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.04,
                      ),
                      Text(
                        'create an account and start booking now.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.04,
                      ),
                      TextFieldComponent(
                        label: 'Name',
                        controller: cubit.registerNameController,
                        onChanged: (value) {
                            cubit.handleTextFieldErrorChanged(value);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.03,
                      ),
                      TextFieldComponent(
                        label: 'Email',
                        controller: cubit.registerEmailController,
                        validator: (value) {
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                              .hasMatch(value);
                          if (value.isEmpty) {
                            return 'please enter your email';
                          } else if (!emailValid) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.03,
                      ),
                      TextFieldComponent(
                        label: 'Phone',
                        controller: cubit.registerPhoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your phone';
                          }
                          if (value.length != 11) {
                            return 'Phone number must be 11 digits.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.03,
                      ),
                      TextFieldComponent(
                        label: 'Password',
                        controller: cubit.registerPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter your password';
                          }
                          else if (value.length < 6) {
                            return 'Password must be at least 6 characters.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.03,
                      ),
                      TextFieldComponent(
                        label: 'Confirm password',
                        controller: cubit.registerConfirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'please enter confirm password';
                          }
                          if (value != cubit.registerPasswordController.text) {
                            return 'Passwords do not match.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.03,
                      ),
                      RadioListTile(
                        title: Text('Male',style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                        ),),
                        value: 1,
                        contentPadding: EdgeInsets.zero,
                        groupValue: cubit.groupValue,
                        onChanged: (value) {
                          cubit.handleRadioListChanged(value);
                        },
                        activeColor: defaultColor,
                      ),
                      SizedBox(
                        height: ScreenSize.screenHeight * 0.01,
                      ),
                      RadioListTile(
                        title: Text('Female',style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w600,
                            fontSize: 14
                        ),),
                        contentPadding: EdgeInsets.zero,
                        value: 2,
                        groupValue: cubit.groupValue,
                        onChanged: (value) {
                          cubit.handleRadioListChanged(value);
                        },
                        activeColor: defaultColor,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextButton(
                            onPressed: (){},

                            child: Text(
                              'Login here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: ScreenSize.screenHeight * 0.01,
                      ),
                      defaultButton(
                          text: 'CREATE',
                          onpressed: () {
                            print('object');
                            if (cubit.registerFormKey.currentState!.validate()) {
                              print('Validated');
                              cubit.registerUser(context);
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
