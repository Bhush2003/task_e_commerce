import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:e_commerce_responsive/ui/product/web/product_detail.dart';
import 'package:e_commerce_responsive/ui/utils/consts/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../framework/repository/dashbord/repository/dashboard_provider.dart';
import '../../../framework/repository/cart_checkout/repository/cart_provider.dart';



class ProductListWeb extends ConsumerWidget {
  const ProductListWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ProductDetailModel> productDetailList = ref.watch(dashboardProvider);
    return Scaffold(
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
                      child: GridView.builder(
                        itemCount: productDetailList.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 230,
                        ),

                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailWeb(productDetailModel: productDetailList[index])));
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 100,
                                      width: 150,
                                      child: Image.network(productDetailList[index].url[0])),
                            
                                  Text(productDetailList[index].name,style: AppTextStyle.headerStyle(20, FontWeight.w400),),
                            
                                  SizedBox(
                                    height: 5,
                                  ),
                            
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('${productDetailList[index].price}'),
                                      Text('${productDetailList[index].rating}/5')
                                    ],
                                  ),
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
                                ],
                              ),
                            ),
                          );
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
    );
  }
}
