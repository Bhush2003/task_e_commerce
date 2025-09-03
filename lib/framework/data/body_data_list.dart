import 'package:e_commerce_responsive/framework/repository/auth/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../ui/dashbord/mobile/helper/product_list.dart';
import '../../ui/profile/mobile/profile.dart';

List bodyDataList = [
  ProductList(),
  Container(),
  Profile(
    user: User(
      email: "email",
      password: "password",
      userId: "userId",
      imagePath: "",
    ),
  ),
];
