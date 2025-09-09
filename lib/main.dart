import 'package:e_commerce_responsive/framework/repository/auth/repository/simple_user.dart';
import 'package:e_commerce_responsive/ui/splash_scren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'framework/repository/cart_checkout/model/orders_models.dart';
import 'framework/repository/product/model/product_detail_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(SimpleUserAdapter());
  Hive.registerAdapter(OrdersModelsAdapter());
  Hive.registerAdapter(ProductDetailModelAdapter());

  await Hive.openBox<SimpleUser>('User_Box');
  await Hive.openBox<OrdersModels>('Orders_Box');
  await Hive.openBox<ProductDetailModel>('Product_Box');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: SplashScreen(),
    );
  }
}
