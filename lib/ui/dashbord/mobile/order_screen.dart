import 'package:e_commerce_responsive/framework/provider/order/order_provider.dart';
import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/consts/colors/colors.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    List<OrdersModels> orderDeatilList =ref.read(orderProvider);
    return Scaffold(
      body: Padding(
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
                    ChoiceChip(label: Text("Pending"), selected: true),
                    SizedBox(width: 10),
                    ChoiceChip(label: Text("Shipped"), selected: true),
                    SizedBox(width: 10),
                    ChoiceChip(label: Text("Delivered"), selected: true),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: orderDeatilList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      onTap: () {},
                      leading: Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsetsGeometry.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          image: DecorationImage(
                            image: NetworkImage(orderDeatilList[index].productDetailModel[0].url[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(orderDeatilList[index].productDetailModel[0].name),
                      subtitle: Text(
                        orderDeatilList[index].productDetailModel[0].description,
                        softWrap: true,
                      ),
                      trailing: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text("Status"),

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
}
