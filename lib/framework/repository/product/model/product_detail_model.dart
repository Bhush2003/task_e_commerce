import 'package:hive/hive.dart';
part 'product_detail_model.g.dart';

@HiveType(typeId: 0)
class ProductDetailModel {
  @HiveField(0)
  final List<String> url;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String category;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double price;

  @HiveField(5)
  final int avalableCount;

  @HiveField(6)
  final int rating;

  @HiveField(7)
  final bool isLiked;

  const ProductDetailModel({
    required this.url,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.avalableCount,
    required this.rating,
    required this.isLiked,
  });

  ProductDetailModel copyWith({
    List<String>? url,
    String? name,
    String? category,
    String? description,
    double? price,
    int? avalableCount,
    int? rating,
    bool? isLiked,
  }) {
    return ProductDetailModel(
      url: url ?? this.url,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.category,
      price: price ?? this.price,
      avalableCount: avalableCount ?? this.avalableCount,
      rating: rating ?? this.rating,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
