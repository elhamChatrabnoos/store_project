import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/product_item.dart';

import '../../controllers/product_controller.dart';
import '../../shared_class/custom_search.dart';

class AllProductListPage extends GetView<ProductController> {
  const AllProductListPage({Key? key}) : super(key: key);

  // Todo check find for this page instead of lazyPut
  // final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
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
                onItemClick: () => Get.to(
                  ProductDetailsPage(product: productList[index]),
                ),
                addToBasketClick: () {
                  productController.addProductToBasket(productList[index]);
                },
                onAddBtnClick: () {
                  productController.searchProductInBasket(productList[index]);
                  productController
                      .addProductToBasket(productController.targetProduct!);
                },
                onRemoveBtnClick: () {
                  productController.searchProductInBasket(productList[index]);
                  productController.removeProductFromBasket(
                      productController.targetProduct!);
                },
                product:
                    productController.searchProductInBasket(productList[index])
                        ? productController.targetProduct!
                        : productList[index],
                productIndex: index,
              );
            });
      },
    );
  }
}
