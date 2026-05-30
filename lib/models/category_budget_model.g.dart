// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryBudgetAdapter extends TypeAdapter<CategoryBudget> {
  @override
  final int typeId = 3;

  @override
  CategoryBudget read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryBudget(
      month: fields[0] as String,
      year: fields[1] as String,
      budgetAmount: fields[2] as double,
      categoryId: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryBudget obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.month)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.budgetAmount)
      ..writeByte(3)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryBudgetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
