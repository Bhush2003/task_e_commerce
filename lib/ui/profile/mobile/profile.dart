import 'dart:io';
import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/repository/auth/model/logging_detail.dart';
import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:e_commerce_responsive/ui/auth/mobile/login/login.dart';
import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:e_commerce_responsive/ui/utils/consts/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SimpleUser user = ref.read(authProvider.notifier).currentUser;

    return LoggingDetail.isGuest?
        Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.secondary,
                  child: Icon(Icons.person, size: 50)
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
        )
        :Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage:
              user.imagePath.isNotEmpty
                  ? FileImage(File(user.imagePath))
                  : null,
              backgroundColor: AppColors.secondary,
              child:  user.imagePath.isEmpty
                  ? Icon(Icons.person, size: 50)
                  : null,
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
