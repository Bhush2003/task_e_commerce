import 'package:e_commerce_responsive/framework/repository/cart_checkout/repository/cart_provider.dart';
import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:e_commerce_responsive/ui/helper/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../framework/repository/dashbord/repository/dashboard_provider.dart';
import '../../../product/mobile/product_detail/product_detail.dart';
import '../../../utils/consts/colors/colors.dart';

class ProductList extends ConsumerWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductDetailModel> productDetailList = ref.watch(dashboardProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 10,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: productDetailList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                    productDetailModel:
                                        productDetailList[index],
                                  ),
                                ),
                              );
                            },
                            leading: Container(
                              height: 100,
                              width: 100,
                              padding: EdgeInsetsGeometry.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    productDetailList[index].url[0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(productDetailList[index].name),
                            subtitle: Text(
                              productDetailList[index].description,
                              softWrap: true,
                            ),
                            trailing:
                                ref
                                    .watch(cartProvider)
                                    .contains(productDetailList[index])
                                ? Container(width: 0)
                                : IconButton(
                                    onPressed: () {
                                      ref
                                          .read(dashboardProvider.notifier)
                                          .addCart(
                                            ref,
                                            productDetailList[index],
                                          );
                                    },
                                    icon: Icon(Icons.add_shopping_cart),
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
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
