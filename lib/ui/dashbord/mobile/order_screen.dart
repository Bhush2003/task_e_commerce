import 'package:e_commerce_responsive/framework/provider/order/order_provider.dart';
import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/consts/colors/colors.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderDetailList = ref.watch(orderProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Orders"),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: orderDetailList.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "No orders yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your orders will appear here",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ChoiceChip(label: Text("All Orders"), selected: true),
                          SizedBox(width: 10),
                          ChoiceChip(label: Text("Pending"), selected: false),
                          SizedBox(width: 10),
                          ChoiceChip(label: Text("Shipped"), selected: false),
                          SizedBox(width: 10),
                          ChoiceChip(label: Text("Delivered"), selected: false),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 11,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: orderDetailList.length,
                      itemBuilder: (context, index) {
                        final order = orderDetailList[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            onTap: () {
                              _showOrderDetails(context, order);
                            },
                            leading: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.secondary,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    order.productDetailModel.isNotEmpty
                                        ? order.productDetailModel[0].url[0]
                                        : '',
                                  ),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {
                                    // Handle image loading errors
                                  },
                                ),
                              ),
                            ),
                            title: Text(
                              order.productDetailModel.isNotEmpty
                                  ? order.productDetailModel[0].name
                                  : 'Unknown Product',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order ID: ${order.id}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Date: ${_formatDate(order.dateTime)}",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "Items: ${order.itemAdd}",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            trailing: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "Pending",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  void _showOrderDetails(BuildContext context, OrdersModels order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Order Details"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Order ID: ${order.id}"),
              Text("Date: ${_formatDate(order.dateTime)}"),
              Text("User: ${order.user.email}"),
              Text("Total Items: ${order.itemAdd}"),
              SizedBox(height: 16),
              Text("Products:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...order.productDetailModel.map((product) => Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text("• ${product.name} - \$${product.price}"),
              )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
