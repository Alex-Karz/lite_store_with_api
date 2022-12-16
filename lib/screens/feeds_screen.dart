import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final ScrollController _scrollController = ScrollController();
  int limit = 10;
  bool _isLoading = false;
  final bool _isLimit = false;
  List<ProductsModel> productsList = [];

  @override
  void initState() {
    getListProducts();
    super.initState();
  }

  Future<void> getListProducts() async {
    productsList = await APIHandler.getAllProducts(limit: limit.toString());
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit += 10;
        log('Добавили Лимит $limit');
        await getListProducts();
        _isLoading = false;
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('All Products'),
          centerTitle: true,
        ),
        body: productsList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // controller: _scrollController,
                      itemCount: productsList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 0,
                        mainAxisSpacing: 0,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(value: productsList[index], child: const FeedsWidget());
                      },
                    ),
                    if (!_isLoading) const Center(child: CircularProgressIndicator(),),
                  ],
                ),
              ));
  }
}
