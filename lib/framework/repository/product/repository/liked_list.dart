import 'package:e_commerce_responsive/framework/repository/product/model/product_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likedList = StateNotifierProvider<ListStaticNotifier,List<ProductDetailModel>>((ref){
  return ListStaticNotifier();
});

class ListStaticNotifier extends StateNotifier<List<ProductDetailModel>>{
  ListStaticNotifier():super([]);

  void addItem(ProductDetailModel productDetailModel){
    state =[...state,productDetailModel];
  }

  void removeItem(ProductDetailModel productDetailModel){
    state.remove(productDetailModel);
    state=state;
  }

  bool containsItem(ProductDetailModel productDetailModel){

    state.any((item)=>item==productDetailModel);

    return false;
  }

}
