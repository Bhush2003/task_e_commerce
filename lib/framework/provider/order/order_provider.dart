import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:e_commerce_responsive/framework/repository/cart_checkout/repository/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, List<OrdersModels>>((ref) {
  return OrderNotifier();
});

class OrderNotifier extends StateNotifier<List<OrdersModels>> {
  OrderNotifier() : super([]) {
    _loadOrders();
  }

  final OrderRepository _orderRepository = OrderRepository();

  Future<void> _loadOrders() async {
    try {
      await _orderRepository.init();
      final orders = _orderRepository.getAllOrders();
      state = orders;
    } catch (e) {
      print('Error loading orders: $e');
      state = [];
    }
  }

  Future<void> addToOrder(OrdersModels order) async {
    try {
      await _orderRepository.addOrder(order);
      state = [...state, order];
    } catch (e) {
      print('Error adding order: $e');
      rethrow;
    }
  }

  Future<void> removeFromOrder(String orderId) async {
    try {
      await _orderRepository.removeOrder(orderId);
      state = state.where((item) => item.id != orderId).toList();
    } catch (e) {
      print('Error removing order: $e');
      rethrow;
    }
  }

  Future<void> clearAllOrders() async {
    try {
      await _orderRepository.clearAllOrders();
      state = [];
    } catch (e) {
      print('Error clearing orders: $e');
      rethrow;
    }
  }

  List<OrdersModels> getOrdersByUser(String userEmail) {
    return _orderRepository.getOrdersByUser(userEmail);
  }

  bool isInOrder(OrdersModels order) {
    return state.any((item) => item.id == order.id);
  }

  int get orderCount => state.length;
}