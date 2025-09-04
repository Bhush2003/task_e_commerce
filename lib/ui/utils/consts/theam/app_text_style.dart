import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle{
  static TextStyle headerStyle(double fontSize,FontWeight fontWeight){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: AppColors.text,
    );
  }
}