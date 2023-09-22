// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_if_null_operators

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

Widget TextFieldComponent({
  required TextEditingController controller,
  TextInputType? keyType,
  required String label,
  Icon? picon,
  onTap,
  //required onChanged,
  TextStyle? labelStyle,
  validator,
  onChanged,
  IconButton? sicon,
  bool isPassword = false,
  bool showError = false,

  //onSubmit,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyType,
      validator: validator,
      onTap: onTap,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //onChanged: onChanged,
      //onFieldSubmitted: onSubmit,
      style: TextStyle(
        color: Colors.black,
      ),

      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        //label: label,
        labelStyle: labelStyle,
        focusColor: defaultColor,
        hoverColor: defaultColor,
        prefixIcon: picon,
        errorText: showError ? null : null,
        suffixIcon: sicon != null ? sicon : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: defaultColor,
            width: 2.0,
          ),
        ),
      ),
    );
Widget defaultButton({
  required String text,
  required onpressed,
  double? width_,
}) =>
    Container(
      width: width_ != null ? width_ : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: defaultColor,
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17
          ),
        ),
        onPressed: onpressed,
      ),
    );
Widget smalldefaultButton({
  required String text,
  required onpressed,
  required color,
  required context,
  textColor,
}) =>
    Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: MaterialButton(
        child: Text(
          text,
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        onPressed: onpressed,
      ),
    );
Widget defaultTextButton({
  required color,
  required String text,
  required onpressed,
  double? textFontSize,
}) =>
    TextButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: textFontSize!=null ? textFontSize : 14,
          fontFamily:
              'assets/fonts/IBMPlexArabic/IBMPlexSansArabic-SemiBold.ttf',
        ),
      ),
    );

Widget normalButton({
  required String text,
  required onPressed,
}) =>
    Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        // gradient: onPressed != null ? gradient : disabledGradient,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Colors.blue),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        onPressed: onPressed,
      ),
    );

Widget SmallButton({
  required onPressed,
  required String title,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 55,
      height: 30.0,
      decoration: BoxDecoration(
        color: Color(0xffF6F8F9),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: MaterialButton(
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff70798C),
          ),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    ),
  );
}

Widget buildValidatorContainer({
  required String content,
}) {
  return Container(
    padding: EdgeInsets.all(5.0),
    width: double.infinity,
    decoration: BoxDecoration(
      color: defaultColor.withOpacity(0.15),
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 20.0,
        ),
        Container(
          height: 20.0,
          width: 20.0,
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 15.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFA5457),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              content,
              maxLines: 2,
              style: TextStyle(
                color: Color(0xffFA5457),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget Alert(content, context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: TextStyle(
                  color: defaultColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              smalldefaultButton(
                context: context,
                color: defaultColor,
                onpressed: () {
                  Navigator.pop(context);
                },
                text: 'Ok',
              ),
            ],
          ),
        ),
      ),
    );