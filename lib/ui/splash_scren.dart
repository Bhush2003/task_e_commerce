import 'dart:async';
import 'package:e_commerce_responsive/framework/controllers/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth/mobile/login/login.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends ConsumerState{

  @override
  void initState() {
    super.initState();
    SignUpController().addAllData(ref);
    Timer(Duration(seconds: 7),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()),(route)=>false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1BnZzmFWdEWO__akUfahVvxIZ-QxUM3UhPg&s"),
      ),
    );
  }
}
