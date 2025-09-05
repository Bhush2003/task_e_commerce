// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductDetailModelAdapter extends TypeAdapter<ProductDetailModel> {
  @override
  final int typeId = 0;

  @override
  ProductDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductDetailModel(
      url: (fields[0] as List).cast<String>(),
      name: fields[1] as String,
      category: fields[2] as String,
      description: fields[3] as String,
      price: fields[4] as double,
      avalableCount: fields[5] as int,
      rating: fields[6] as int,
      isLiked: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ProductDetailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.avalableCount)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.isLiked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
