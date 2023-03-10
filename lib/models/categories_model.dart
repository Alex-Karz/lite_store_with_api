

import 'package:flutter/cupertino.dart';

class CategoriesModel with ChangeNotifier {
  int? id;
  String? name;
  String? image;

  CategoriesModel({required this.id, required this.name, required this.image});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  static List<CategoriesModel> categoriesFromFakeData(List categoriesFrom) {
    return categoriesFrom.map((data) {
      return CategoriesModel.fromJson(data);
    }).toList();
  }
}