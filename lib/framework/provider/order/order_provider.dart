import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final orderProvider = StateNotifierProvider<OrderNotifier, List<OrdersModels>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<OrdersModels>>{
  OrderNotifier(): super([]);

  void addToOrder(OrdersModels product) {
    if (!state.any((item) => item.productDetailModel[0].name == product.productDetailModel[0].name)) {
      state = [...state, product];
    }
  }

  void removeFromOrder(OrdersModels product) {
    state = state.where((item) => item.productDetailModel[0].name != product.productDetailModel[0].name).toList();
  }

  void clearCart() {
    state = [];
  }

  bool isInCart(OrdersModels product) {
    return state.any((item) => item.productDetailModel[0].name == product.productDetailModel[0].name);
  }

  int get cartItemCount => state.length;
}