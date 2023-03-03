import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/pages/all_product_list_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/custom_text_field.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../../shared_class/custom_search.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<String> sliderImages = [
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg'];

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => ProductController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppColors.grayColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
              body: _bodyItems(context))
        );
  }

  Widget _bodyItems(BuildContext context) {
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
            _productOfCategories(context),
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
            Get.to(() => AllProductListPage());
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

  Widget _productOfCategories(BuildContext context) {
    return
      SizedBox(
        height: MediaQuery.of(context).size.height/2.5,
            child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return index == 4
                    ? _moreButton()
                    : HomeProductItem(
                        onItemClick: () {
                          Get.to(() => ProductDetailsPage(
                            product: productList[index],
                          ));
                        },
                        product: productList[index],
                      );
              },
            )
    );
    // );
  }

  Widget _moreButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => Get.to(() => AllProductListPage()),
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
              child: Image.asset(sliderImages[index]));
        },
        options: CarouselOptions(autoPlay: false));
  }

  PreferredSize _appBarWithSearch() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(95),
      child: AppBar(
        automaticallyImplyLeading: false,
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
