import 'dart:io';
import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/ui/auth/mobile/login/login.dart';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:e_commerce_responsive/ui/utils/consts/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../framework/repository/auth/model/user.dart';

class Profile extends ConsumerWidget {
  final User user;
  const Profile({super.key, required this.user});

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

            SizedBox(height: 10),

            Text(
              user.email,
              style: AppTextStyle.headerStyle(24, FontWeight.w500),
            ),

            SizedBox(height: 40),
            LoggingDetail.isGuest
                ? ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => route.isFirst,
                      );
                    },
                    child: Text(
                      "Log In",
                      style: AppTextStyle.headerStyle(20, FontWeight.w500),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                    ),
                    child: Text(
                      "Log Out",
                      style: AppTextStyle.headerStyle(20, FontWeight.w500),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
