import 'package:e_commerce_responsive/ui/dashbord/mobile/order_screen.dart';
import 'package:e_commerce_responsive/ui/dashbord/web/order_screen.dart';
import 'package:e_commerce_responsive/ui/dashbord/web/product_list.dart';
import 'package:e_commerce_responsive/ui/profile/web/profile_web.dart';
import '../../ui/dashbord/mobile/helper/product_list.dart';
import '../../ui/profile/mobile/profile.dart';

List bodyDataListWeb= [
  ProductListWeb(),
  OrderScreenWeb(),
  ProfileWeb(),
];

List bodyDataList = [
  ProductList(),
  OrderScreen(),
  Profile()
];
