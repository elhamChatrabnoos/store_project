import 'package:flutter/material.dart';

import '../models/product.dart';
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

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _listToShow();
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    return _listToShow();
  }

  Widget _listToShow() {
    List<Product> matchQuery = [];
    for (var product in targetList) {
      if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ProductItem(
          isFade: false,
          iconLike: false,
          onItemClick: () {
            // Get.to(
            //     ProductDetailsPage(product: targetList[index]),
          },
          product: result,
          productIndex: index,
        );
      },
    );
  }

  CustomSearchDelegate({required this.targetList});
}
