import 'dart:io';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:e_commerce_responsive/ui/utils/consts/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../framework/repository/auth/model/user.dart';

class Profile extends ConsumerWidget {

  final User user;
  const Profile( {super.key, required this.user,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: FileImage(File("")),
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.person),
            ),

            SizedBox(height: 10,),

            Text(user.email,style: AppTextStyle.headerStyle(24, FontWeight.w500),),

            SizedBox(
              height: 40,
            ),
            ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.background
            ), child: Text("Log Out",style: AppTextStyle.headerStyle(20, FontWeight.w500),))
          ],
        ),
      ),
    );
  }


}
