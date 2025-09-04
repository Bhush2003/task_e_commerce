import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:flutter/material.dart';
import '../../../../ui/auth/mobile/login/login.dart';
import '../../../../ui/dashbord/mobile/dashbord.dart';

class AuthController{
  void navigateTo( BuildContext context){
    if(LoggingDetail.isLogged){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
    }
  }
}