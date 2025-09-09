import 'package:e_commerce_responsive/ui/profile/mobile/profile.dart';
import 'package:e_commerce_responsive/ui/profile/web/profile_web.dart';
import 'package:flutter/material.dart';
import '../../responsive_dashboard.dart';

class ResponsiveLayoutDashbord extends StatelessWidget {
  const ResponsiveLayoutDashbord({super.key});


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutW(
        mobileBody: Profile(), desktopBody: ProfileWeb());
  }
}