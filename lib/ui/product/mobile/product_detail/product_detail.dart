import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:e_commerce_responsive/ui/utils/consts/theam/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../framework/data/liked_list.dart';
import '../../../../framework/data/product_list_data.dart';
import '../../../../framework/repository/cart_checkout/repository/cart_provider.dart';
import '../../../../framework/repository/product/model/product_detail_model.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final ProductDetailModel productDetailModel;
  const ProductDetail({super.key, required this.productDetailModel});

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends ConsumerState<ProductDetail> {
  bool active1 = false;
  bool active2 = false;
  String exTitle = "Sport Categories";

  late final filteredProducts = productDetailList
      .where((p) => p.category == widget.productDetailModel.category)
      .toList();

  @override
  Widget build(BuildContext context) {
    // Watch the entire cart to ensure UI rebuilds when cart changes
    final cart = ref.watch(cartProvider);
    final isInCart = cart.any(
          (item) => item.name == widget.productDetailModel.name,
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Product Detail"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (likedList.contains(widget.productDetailModel)) {
                likedList.remove(widget.productDetailModel);
              } else {
                likedList.add(widget.productDetailModel);
              }
            },
            icon: Icon(
              Icons.favorite,
              color: likedList.contains(widget.productDetailModel)
                  ? AppColors.error
                  : AppColors.success,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: SingleChildScrollView(
          child: Container(
            height: 1000,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),

                Center(
                  child: Text(
                    widget.productDetailModel.name,
                    style: AppTextStyle.headerStyle(24, FontWeight.w900),
                  ),
                ),

                Container(
                  height: 300,
                  width: 400,
                  child: PageView.builder(
                    controller: PageController(),
                    itemCount: widget.productDetailModel.url.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.productDetailModel.url[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                ExpansionPanelList(
                  materialGapSize: 20,
                  expansionCallback: (panelIndex, isExpanded) {
                    setState(() {
                      active1 = !active1;
                      active2 = !active2;
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, index) {
                        return Text(
                          "Detail",
                          style: AppTextStyle.headerStyle(20, FontWeight.w500),
                        );
                      },
                      isExpanded: active1,
                      canTapOnHeader: true,
                      body: SizedBox(
                        height: 80,
                        child: Text(
                          widget.productDetailModel.description,
                          style: AppTextStyle.headerStyle(18, FontWeight.w400),
                        ),
                      ),
                    ),
                    ExpansionPanel(
                      isExpanded: active2,
                      canTapOnHeader: true,
                      headerBuilder: (context, index) {
                        return Text(
                          "Rating",
                          style: AppTextStyle.headerStyle(20, FontWeight.w500),
                        );
                      },
                      body: ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text("${widget.productDetailModel.rating}/5"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Price",
                          style: AppTextStyle.headerStyle(16, FontWeight.w400),
                        ),
                        Text(
                          "\$ ${widget.productDetailModel.price}",
                          style: AppTextStyle.headerStyle(16, FontWeight.w400),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Available now",
                          style: AppTextStyle.headerStyle(16, FontWeight.w400),
                        ),
                        Text(
                          "In stock",
                          style: AppTextStyle.headerStyle(16, FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: TextField(
                        decoration: InputDecoration(border: OutlineInputBorder()),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.keyboard_arrow_down),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                if (!isInCart) ...[
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(cartProvider.notifier)
                            .addToCart(widget.productDetailModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.productDetailModel.name} added to cart!',
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                      ),
                      child: Text(
                        "Add to cart",
                        style: AppTextStyle.headerStyle(22, FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ] else ...[
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(cartProvider.notifier)
                            .removeFromCart(widget.productDetailModel);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.productDetailModel.name} removed from cart!',
                            ),
                            backgroundColor: AppColors.error,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                      ),
                      child: Text(
                        "Remove from cart",
                        style: AppTextStyle.headerStyle(22, FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                    ),
                    child: Text(
                      "Buy now",
                      style: AppTextStyle.headerStyle(22, FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}