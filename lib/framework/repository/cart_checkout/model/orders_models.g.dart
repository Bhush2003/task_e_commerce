// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdersModelsAdapter extends TypeAdapter<OrdersModels> {
  @override
  final int typeId = 2;

  @override
  OrdersModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdersModels(
      productDetailModel: (fields[0] as List).cast<ProductDetailModel>(),
      itemAdd: fields[1] as int,
      id: fields[2] as String,
      dateTime: fields[3] as DateTime,
      user: fields[4] as SimpleUser,
    );
  }

  @override
  void write(BinaryWriter writer, OrdersModels obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productDetailModel)
      ..writeByte(1)
      ..write(obj.itemAdd)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.user);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdersModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
