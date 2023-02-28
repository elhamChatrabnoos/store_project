import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:shop_getx/models/product.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/product_controller.dart';

class AllProductListPage extends StatelessWidget {
  AllProductListPage({Key? key}) : super(key: key);

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                  // delegate to customize the search bar
                );
              },
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: _productList());
  }

  Widget _productList() {
    return GetBuilder<ProductController>(
      assignId: true,
      builder: (productController) {
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductItem(
                onItemClick: () =>
                    Get.to(ProductDetailsPage(product: productList[index])),
                addToBasketClick: () {
                  productController.addProductToBasket(productList[index]);
                },
                onAddBtnClick: () =>
                    productController.addProductToBasket(productList[index]),
                onRemoveBtnClick: () {
                  num? productCount = buyBasketList[index].productCountInBasket;
                  if (productCount! > 1) {
                    productController.removeProductFromBasket(
                        buyBasketList[index]);
                  } else {
                    // Todo show dialog before delete
                    buyBasketList.removeAt(index);
                  }
                },
                product: productList[index],
                productIndex: index,
              );
            });
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}