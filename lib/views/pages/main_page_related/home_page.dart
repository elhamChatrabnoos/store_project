import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/home_page_controller.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/pages/all_product_list_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/custom_text_field.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../../models/product.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(appBar: _appBarWithSearch(), body: _bodyItems()));
  }

  Widget _bodyItems() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imagesSlider(),
            AppSizes.normalSizeBox2,
            _categoryTitle('شوینده ها'),
            _productOfCategories(),
            AppSizes.normalSizeBox2,
            _categoryTitle('حبوبات'),
            _productOfCategories(),
            AppSizes.bigSizeBox,
          ],
        ),
      ),
    );
  }

  Widget _categoryTitle(String categoryTitle) {
    return Row(
      children: [
        CustomText(
            text: categoryTitle, textSize: 20, textWeight: FontWeight.bold),
        const Spacer(),
        InkWell(
          onTap: () {
            Get.to(AllProductListPage());
          },
          child: CustomText(
              text: 'مشاهده همه',
              textColor: AppColors.buttonColor,
              textSize: 17,
              textWeight: FontWeight.normal),
        )
      ],
    );
  }

  Widget _productOfCategories() {
    return SizedBox(
          height: AppSizes.bigSizeBox.height! * 2,
      child:SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:  Row(
        children: productController.productList.map((element) {
          int index = productController.productList.indexOf(element);
          if(index == 4) {
            return _moreButton();
          } else {
            return
          HomeProductItem(
            onItemClick: () {
              Get.to(ProductDetailsPage(
                product: productController.productList[index],
              ));
            },
            product: productController.productList[index],
          );
          }


        }).toList(),
      ),),
      // ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   shrinkWrap: true,
      //   itemCount: AppSizes.numberOfListItem,
      //   itemBuilder: (context, index) {
      //     return index == 4
      //         ? _moreButton()
      //         : HomeProductItem(
      //             onItemClick: () {
      //               Get.to(ProductDetailsPage(
      //                 product: productController.productList[index],
      //               ));
      //             },
      //             product: productController.productList[index],
      //           );
      //   },
      // )
    );
  }

  Widget _moreButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => Get.to(AllProductListPage()),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CustomText(
              textSize: 15,
              text: 'همه محصولات',
              textColor: Colors.lightBlueAccent,
              textWeight: FontWeight.normal,
            ),
            Icon(
              Icons.arrow_circle_left_outlined,
              size: 40,
              color: Colors.lightBlueAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagesSlider() {
    return CarouselSlider.builder(
        itemCount: 2,
        itemBuilder: (context, index, realIndex) {
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(homeController.sliderImages[index]));
        },
        options: CarouselOptions(autoPlay: false));
  }

  PreferredSize _appBarWithSearch() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90),
      child: AppBar(
        flexibleSpace: Container(
            margin:
                const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
            child: CustomTextField(
              radius: 5,
              fillColor: Colors.white38,
              icon: const Icon(Icons.search),
              borderColor: Colors.grey,
              hintText: 'جست و جوی محصول',
            )),
      ),
    );
  }
}
