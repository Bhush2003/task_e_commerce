import 'package:e_commerce_responsive/ui/utils/consts/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../framework/data/appbar_title.dart';
import '../../../framework/data/body_data_list.dart';
import '../../../framework/repository/dashbord/repository/tab_provider.dart';
import '../../cart_checkout/mobile/cart_screen.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int selectedIndex = ref.watch(tabProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(appbarTitle[selectedIndex]),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
        centerTitle: true,
      ),
      body: bodyDataList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          ref.read(tabProvider.notifier).state = index;
        },
        selectedItemColor: AppColors.text,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Product",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Orders"),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
