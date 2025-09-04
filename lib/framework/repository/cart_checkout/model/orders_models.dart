import 'package:e_commerce_responsive/framework/repository/auth/model/user.dart';
import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:hive/hive.dart';

import '../../auth/repository/simple_user.dart';

part 'orders_models.g.dart';

@HiveType(typeId: 2)
class OrdersModels {
  @HiveField(0)
  final List<ProductDetailModel> productDetailModel;

  @HiveField(1)
  final int itemAdd;

  @HiveField(2)
  final String id;

  @HiveField(3)
  final DateTime dateTime;

  @HiveField(4)
  final SimpleUser user;

  const OrdersModels({
    required this.productDetailModel,
    required this.itemAdd,
    required this.id,
    required this.dateTime,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      "productDetailModel": productDetailModel,
      "itemAdd": itemAdd,
      "id": id,
      "dateTime": dateTime,
      "user": user,
    };
  }
}
