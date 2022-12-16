import 'dart:convert';

import 'package:http/http.dart' as http;

import '../consts/api_const.dart';
import '../models/categories_model.dart';
import '../models/products_model.dart';
import '../models/users_model.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target, String? limit}) async {
    try {
      var client = http.Client();
      var uri = Uri.https(
          BASE_URL,
          '/api/v1/$target',
          target == 'products'
              ? {
                  'offset': '0',
                  'limit': limit,
                }
              : {});

      var response = await client.get(uri);

      var data = jsonDecode(response.body);
      List tempList = [];
      if (response.statusCode != 200) {
        throw data['message'];
      }
      for (var itemData in data) {
        tempList.add(itemData);
      }
      return tempList;
    } catch (error) {
      print('An error occured $error');
      throw error.toString();
    }
  }

  static Future<List<ProductsModel>> getAllProducts({required String? limit}) async {
    var tempListProducts = await getData(target: 'products', limit: limit);
    return ProductsModel.productsFromFakeData(tempListProducts);
  }

  static Future<List<CategoriesModel>> getAllCategories() async {
    var tempListCategories = await getData(target: 'categories');
    return CategoriesModel.categoriesFromFakeData(tempListCategories);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    var tempListCategories = await getData(target: 'users');
    return UsersModel.usersFromFakeData(tempListCategories);
  }

  static Future<ProductsModel> getProductById({required String id}) async {
    try {
      var client = http.Client();
      var uri = Uri.https(BASE_URL, '/api/v1/products/$id');

      var response = await client.get(uri.replace());

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw data['message'];
      }
      return ProductsModel.fromJson(data);
    } catch (error) {
      print('an error occured while getting product info $error');
      throw error.toString();
    }
  }

// Использовал 2 метода, но так как код повторяется, а мы должны соблюдать DRY, то выше сделано иначе!!!!
//   static Future<List<ProductsModel>> getAllProducts() async {
//     var client = http.Client();
//     var uri = Uri.https(BASE_URL, '/api/v1/products');
//
//     var response = await client.get(uri);
//
//     var data = jsonDecode(response.body);
//     List tempList = [];
//     for (var itemData in data) {
//       if (tempList.length < 12) {
//         tempList.add(itemData);
//       }
//     }
//     return ProductsModel.productsFromFakeData(tempList);
//   }
//
//   static Future<List<CategoriesModel>> getAllCategories() async {
//     var client = http.Client();
//     var uri = Uri.https(BASE_URL, '/api/v1/categories');
//
//     var response = await client.get(uri);
//
//     var data = jsonDecode(response.body);
//     List tempList = [];
//     for (var itemData in data) {
//       if (tempList.length < 12) {
//         tempList.add(itemData);
//       }
//     }
//     return CategoriesModel.categoriesFromFakeData(tempList);
//   }
}
