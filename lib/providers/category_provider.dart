import 'package:flutter/widgets.dart';

class CategoryProvider with ChangeNotifier{
  int? _selectedCategory;

  int? get selectedCategory => _selectedCategory;

  
  void changeCategory(int? category){
    _selectedCategory = category;
    notifyListeners();
  }

  void resetCategory(){
    _selectedCategory = null;
    notifyListeners();
  }
}