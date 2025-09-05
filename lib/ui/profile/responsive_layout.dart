import 'package:e_commerce_responsive/ui/profile/mobile/profile.dart';
import 'package:e_commerce_responsive/ui/profile/web/profile_web.dart';
import 'package:flutter/material.dart';
import '../../framework/repository/auth/repository/simple_user.dart';
import '../../responsive_dashboard.dart';

class ResponsiveLayout extends StatelessWidget {


  const ResponsiveLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutW(mobileBody: Profile( ), desktopBody: ProfileWeb(),);
  }
}