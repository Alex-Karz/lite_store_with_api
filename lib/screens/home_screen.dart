import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:lite_shop_api/screens/users_screen.dart';

import '../consts/global_colors.dart';
import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widgets/appbar_icon.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/sale_widget.dart';
import 'category_screen.dart';
import 'feeds_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Tiny-Store'),
          leading: AppBarIcon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoryScreen(),
                ),
              );
            },
            icon: Icons.grain,
          ),
          actions: [
            AppBarIcon(
              padding: 12,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UsersScreen(),
                  ),
                );
              },
              icon: Icons.group,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 28,
                  ),
                  hintText: 'Search',
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: Theme.of(context).backgroundColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(width: 1, color: textFieldFocusColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.22,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: SaleWidget(item: index.toString(),),
                            );
                          },
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                                color: Colors.white, activeColor: Colors.redAccent, activeSize: 15),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Row(
                          children: [
                            const Text('Latest Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const Spacer(),
                            AppBarIcon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const FeedsScreen(),
                                    ),
                                  );
                                },
                                icon: Icons.arrow_forward_outlined),
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProducts(limit: 10.toString()),
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
                            return FeedsGrid(
                              productsList: snapshot.data!,
                            );
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
