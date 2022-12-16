import 'package:flutter/cupertino.dart';

import 'categories_model.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;
  int? categoryId;

  ProductsModel(
      {required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.images,
        required this.categoryId});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = (json['category'] != null ? CategoriesModel.fromJson(json['category']) : null)!;
    images = json['images'].cast<String>();
    categoryId = json['categoryId'];
  }
  static List<ProductsModel> productsFromFakeData(List productFrom) {
    return productFrom.map((data) {
      return ProductsModel.fromJson(data);
    }).toList();
  }
}
