import 'package:drift/drift.dart';
// import 'package:flutter/material.dart';

class Expenses extends Table{
  TextColumn get id => text().withLenght(min: 1, max: 100)(); 
}