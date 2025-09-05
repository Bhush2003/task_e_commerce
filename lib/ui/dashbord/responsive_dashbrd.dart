import 'package:e_commerce_responsive/ui/dashbord/web/dashbord.dart';
import 'package:flutter/material.dart';
import '../../responsive_dashboard.dart';
import 'mobile/dashbord.dart';

class ResponsiveLayoutDashbord extends StatelessWidget {
  const ResponsiveLayoutDashbord({super.key});


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutW(
        mobileBody: Dashboard(), desktopBody: DashboardWeb());
  }
}