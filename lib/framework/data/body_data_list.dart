import 'package:e_commerce_responsive/framework/repository/auth/model/user.dart';
import 'package:e_commerce_responsive/ui/dashbord/mobile/order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ui/dashbord/mobile/helper/product_list.dart';
import '../../ui/profile/mobile/profile.dart';

List bodyDataList = [
  ProductList(),
  OrderScreen(),
  Profile(
    user: User(
      email: "email",
      password: "password",
      userId: "userId",
      imagePath: "",
    ),
  ),
];
