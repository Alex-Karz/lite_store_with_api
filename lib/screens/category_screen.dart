import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/categories_model.dart';
import '../services/api_handler.dart';
import '../widgets/categories_widget.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(235, 240, 240, 1),
        appBar: AppBar(
          title: const Text('Categories'),
          elevation: 2,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
            child: FutureBuilder<List<CategoriesModel>>(
                future: APIHandler.getAllCategories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('An error occurred - ${snapshot.error}'),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text('No products has been added yet'),
                    );
                  }
                  return GridView.builder(
                      itemCount: 5,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: snapshot.data![index], child: const CategoriesWidget());
                      });
                })));
  }
}
