import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../models/product.dart';
import '../views/pages/product_details_page.dart';
import '../views/widgets/product_item.dart';

class CustomSearchDelegate extends SearchDelegate {

  List<Product> targetList;

// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return _listToShow();
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return _listToShow();
  }

  Widget _listToShow() {
    List<Product> matchQuery = [];
    for (var product in productList) {
      if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ProductItem(
          iconLike: false,
          onItemClick: () => Get.to(
            ProductDetailsPage(product: productList[index]),
          ),
          product: result,
          productIndex: index,
        );
      },
    );
  }

  CustomSearchDelegate({required this.targetList});
}
