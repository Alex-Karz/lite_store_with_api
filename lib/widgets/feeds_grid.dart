import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import 'feeds_widget.dart';

class FeedsGrid extends StatelessWidget {
  final List<ProductsModel> productsList;
  const FeedsGrid({Key? key, required this.productsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1850,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
            childAspectRatio: 0.64,
          ),
          itemCount: productsList.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(value: productsList[index], child: const FeedsWidget());
          }),
    );
  }
}
