import 'package:e_commerce_responsive/framework/provider/order/order_provider.dart';
import 'package:e_commerce_responsive/framework/repository/cart_checkout/model/orders_models.dart';
import 'package:e_commerce_responsive/framework/repository/dashbord/repository/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/consts/colors/colors.dart';

class OrderScreenWeb extends ConsumerWidget {
  const OrderScreenWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<OrdersModels> orderDeatilList = ref.read(orderProvider);
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
                    ChoiceChip(
                      label: Text("All Orders"),
                      onSelected: (val) {
                        ref.read(chipProvider.notifier).changeChip(0);
                      },
                      selected: ref.read(chipProvider)[0],
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text("Pending"),
                      onSelected: (val) {
                        ref.read(chipProvider.notifier).changeChip(1);
                      },
                      selected: ref.read(chipProvider)[1],
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text("Shipped"),
                      onSelected: (val) {
                        ref.read(chipProvider.notifier).changeChip(2);
                      },
                      selected: ref.read(chipProvider)[2],
                    ),
                    SizedBox(width: 10),
                    ChoiceChip(
                      label: Text("Delivered"),
                      onSelected: (val) {
                        ref.read(chipProvider.notifier).changeChip(3);
                      },
                      selected: ref.read(chipProvider)[3],
                    ),
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
                          image: NetworkImage(
                            orderDeatilList[index].productDetailModel[0].url[0],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      orderDeatilList[index].productDetailModel[0].name,
                    ),
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
