import 'package:e_commerce_responsive/responsive_dashboard.dart';
import 'package:e_commerce_responsive/ui/auth/web/login/login.dart';
import 'package:flutter/material.dart';

import 'mobile/login/login.dart';

class Responsivelogin extends StatelessWidget {
  const Responsivelogin({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutW(mobileBody: Login(),desktopBody: LoginWeb(),);
  }
}

