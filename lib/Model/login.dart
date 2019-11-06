import 'package:flutter/material.dart';


class Login with ChangeNotifier {

  Login();

  String number = "08166569680";
  String otp = "";



  change(String title){
    this.number = title;
    notifyListeners();
  }

  String get phoneNumber => number;
   set phoneNumbers(String text)=> number = text;
}
