import 'package:e_commerce_responsive/framework/data/product_list_data.dart';
import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cart_checkout/repository/cart_provider.dart';

final dashboardProvider = StateNotifierProvider<DashboardStateNotifier, List<ProductDetailModel>>((ref) {
  return DashboardStateNotifier();
});

class DashboardStateNotifier extends StateNotifier<List<ProductDetailModel>>{
  DashboardStateNotifier() : super([]);

  void addCart(WidgetRef ref, ProductDetailModel productDetailModel){
    ref.watch(cartProvider).add(productDetailModel);
  }

  Future<void> addAllData()async {
    state.addAll(productDetailList);
    state=[...state, ...productDetailList ];
  }

}
