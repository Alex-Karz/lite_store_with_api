import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../screens/product_details.dart';

class FeedsWidget extends StatelessWidget {
  const FeedsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProductsModel productsModelProvider = Provider.of<ProductsModel>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetails(
                  id: productsModelProvider.id.toString(),
                ), // ProductDetails()
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: '\$ ',
                            style: const TextStyle(color: Colors.green, fontSize: 19, fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: '${productsModelProvider.price}',
                                style:
                                    const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.normal),
                              ),
                            ]),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.favorite))
                  ],
                ),
              ),
              ClipRRect(
                child: SizedBox(
                  width: double.infinity,
                  height: size.height * 0.2,
                  child: Image.network(
                    width: double.infinity,
                    fit: BoxFit.contain,
                    productsModelProvider.images![0],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  productsModelProvider.title.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.01,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
