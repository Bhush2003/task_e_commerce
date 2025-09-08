import 'package:hive_flutter/hive_flutter.dart';
import '../model/orders_models.dart';

class OrderRepository {
  static const String _boxName = 'orders_box';
  late Box<OrdersModels> _box;

  Future<void> init() async {
    _box = await Hive.openBox<OrdersModels>(_boxName);
  }

  List<OrdersModels> getAllOrders() {
    return _box.values.toList();
  }

  Future<void> addOrder(OrdersModels order) async {
    await _box.put(order.id, order);
  }

  Future<void> removeOrder(String orderId) async {
    await _box.delete(orderId);
  }

  Future<void> clearAllOrders() async {
    await _box.clear();
  }

  List<OrdersModels> getOrdersByUser(String userEmail) {
    return _box.values.where((order) => order.user.email == userEmail).toList();
  }

  OrdersModels? getOrderById(String orderId) {
    return _box.get(orderId);
  }

  bool isOrderExists(String orderId) {
    return _box.containsKey(orderId);
  }

  int get orderCount => _box.length;

  void dispose() {
    _box.close();
  }
}

