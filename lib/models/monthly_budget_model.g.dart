// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_budget_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyBudgetModelAdapter extends TypeAdapter<MonthlyBudgetModel> {
  @override
  final int typeId = 1;

  @override
  MonthlyBudgetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyBudgetModel(
      monthlyBudgetAmount: fields[0] as double,
      dateUpdated: fields[1] as DateTime,
      month: fields[2] as String,
      year: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyBudgetModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.monthlyBudgetAmount)
      ..writeByte(1)
      ..write(obj.dateUpdated)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.year);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyBudgetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
