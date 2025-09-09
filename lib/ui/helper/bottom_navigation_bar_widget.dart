import 'package:e_commerce_responsive/responsive_dashboard.dart';
import 'package:e_commerce_responsive/ui/dashbord/mobile/helper/product_list.dart';
import 'package:e_commerce_responsive/ui/dashbord/mobile/order_screen.dart';
import 'package:e_commerce_responsive/ui/dashbord/web/order_screen.dart';
import 'package:e_commerce_responsive/ui/dashbord/web/product_list.dart';
import 'package:e_commerce_responsive/ui/profile/mobile/profile.dart';
import 'package:e_commerce_responsive/ui/profile/web/profile_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../framework/repository/dashbord/repository/tab_provider.dart';
import '../utils/consts/colors/colors.dart';

class BottomNavigationBarWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      currentIndex: ref.watch(tabProvider.notifier).state,
      onTap: (index) {
        ref.read(tabProvider.notifier).state = index;
        if(ref.read(tabProvider.notifier).state == 0){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResponsiveLayoutW(mobileBody: ProductList(), desktopBody: ProductListWeb())));
        }else if(ref.read(tabProvider.notifier).state == 1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResponsiveLayoutW(mobileBody: OrderScreen(), desktopBody: OrderScreenWeb())));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ResponsiveLayoutW(mobileBody: Profile(), desktopBody: ProfileWeb())));
        }
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
    );
  }

}
