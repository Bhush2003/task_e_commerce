import 'package:e_commerce_responsive/framework/provider/auth/auth_provider.dart';
import 'package:e_commerce_responsive/framework/provider/order/order_provider.dart';
import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../framework/repository/cart_checkout/repository/cart_provider.dart';
import '../../product/mobile/product_detail/product_detail.dart';
import '../../utils/consts/colors/colors.dart';

class CartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the cart state to ensure UI rebuilds when cart changes
    final productDetailList = ref.watch(cartProvider);

    if (productDetailList.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Cart"), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Add some products to get started",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Cart"), centerTitle: true),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final product = productDetailList[index];
          int noOfRequiredOrder = ref.watch(itemCountProvider);
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetail(productDetailModel: product),
                ),
              );
            },
            leading: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                image: DecorationImage(
                  image: NetworkImage(
                    product.url.isNotEmpty ? product.url[0] : '',
                  ),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    // Handle image loading errors
                  },
                ),
              ),
            ),
            title: Text(product.name),
            subtitle: Text(product.description, softWrap: true),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    if (noOfRequiredOrder > 1) {
                      ref.read(itemCountProvider.notifier).state -= 1;
                    } else {
                      ref.read(cartProvider.notifier).removeFromCart(product);
                    }
                  },
                  icon: noOfRequiredOrder == 1
                      ? Icon(Icons.delete)
                      : Icon(Icons.remove_circle_outline),
                ),

                Text('$noOfRequiredOrder'),
                IconButton(
                  onPressed: () {
                    ref.read(itemCountProvider.notifier).state += 1;
                  },
                  icon: Icon(Icons.add_circle_outline),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: productDetailList.length,
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          OrdersModels order=OrdersModels(
            productDetailModel: productDetailList,
            itemAdd: ref.read(itemCountProvider),
            id: "#123456",
            dateTime: DateTime.now(),
            user: ref.read(authProvider.notifier).currentUser!,
          );
          ref.read(orderProvider.notifier).addToOrder(order);
        },
        child: Text("Check Out"),
      ),
    );
  }
}
