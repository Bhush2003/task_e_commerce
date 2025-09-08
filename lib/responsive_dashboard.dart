import 'package:e_commerce_responsive/ui/utils/consts/app_key.dart';
import 'package:flutter/material.dart';

class ResponsiveLayoutW extends StatefulWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayoutW({super.key, required this.mobileBody, required this.desktopBody});


  @override
  State<ResponsiveLayoutW> createState() => _ResponsiveLayoutWState();
}

class _ResponsiveLayoutWState extends State<ResponsiveLayoutW> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      if(constraints.maxWidth < mobileWidth){
        return widget.mobileBody;
      }else{
        return widget.desktopBody;
      }
    });
  }
}
