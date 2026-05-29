import 'package:drift/drift.dart';
// import 'package:flutter/material.dart';

class ExpenseTable extends Table{
  TextColumn get id => text().withLength(min: 1, max: 100)(); 
  TextColumn get title => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get note => text().nullable()();
  TextColumn get paymentType => text()();
  TextColumn get categoryId => text()();
}

class CategoryTable extends Table{
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get color => text()(); //Color
  TextColumn get icon => text()(); //IconData
}