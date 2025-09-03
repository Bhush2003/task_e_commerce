import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<List<ProductDetailModel>> {
  CartNotifier() : super([]);

  void addToCart(ProductDetailModel product) {
    // Check if product is already in cart
    if (!state.any((item) => item.name == product.name)) {
      state = [...state, product];
    }
  }

  void removeFromCart(ProductDetailModel product) {
    state = state.where((item) => item.name != product.name).toList();
  }

  void clearCart() {
    state = [];
  }

  bool isInCart(ProductDetailModel product) {
    return state.any((item) => item.name == product.name);
  }

  int get cartItemCount => state.length;
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<ProductDetailModel>>((ref) {
      return CartNotifier();
    });

// Provider to check if a specific product is in cart
final isInCartProvider = Provider.family<bool, ProductDetailModel>((
  ref,
  product,
) {
  final cart = ref.watch(cartProvider);
  return cart.any((item) => item.name == product.name);
});

// Debug provider to see cart state
final cartDebugProvider = Provider<String>((ref) {
  final cart = ref.watch(cartProvider);
  return 'Cart items: ${cart.map((e) => e.name).join(', ')}';
});
