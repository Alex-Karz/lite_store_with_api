import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:lite_shop_api/models/products_model.dart';
import 'package:lite_shop_api/services/api_handler.dart';

import '../widgets/appbar_icon.dart';

class ProductDetails extends StatefulWidget {
  final String id;
  const ProductDetails({super.key, required this.id});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final TextStyle titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  final TextStyle categoryStyle = const TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
  ProductsModel? productsDetails;

  Future<void> getProductInfo() async {
    try {
      productsDetails = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      print('error $error');
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: productsDetails == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarIcon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icons.arrow_back_ios),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          productsDetails!.category!.name.toString(),
                          style: categoryStyle,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Можно использовать Flexible вместо этого
                          children: [
                            SizedBox(
                              width: size.width * 0.6,
                              child: Text(
                                productsDetails!.title.toString(),
                                style: titleStyle,
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: '\$',
                                style: const TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: productsDetails!.price.toString(),
                                      style: const TextStyle(color: Colors.black))
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Image.network(
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    productsDetails!.images![index].toString()),
                              );
                            },
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Color.fromARGB(255, 206, 197, 216),
                                  activeColor: Colors.redAccent,
                                  activeSize: 15),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(
                          'Description',
                          style: titleStyle,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Text(productsDetails!.description.toString(),
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                )),
    );
  }
}
