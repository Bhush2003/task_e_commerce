import 'package:flutter/material.dart';
import '../utils/consts/app_key.dart';

class ResponsiveLayout extends StatelessWidget {

  final Widget mobileBody;
  final Widget desktopBody;
  final Widget tabBody;

  const ResponsiveLayout({super.key, required this.mobileBody, required this.desktopBody, required this.tabBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth < mobileWidth){
        return mobileBody;
      }else{
        return desktopBody;
      }
    });
  }
}
