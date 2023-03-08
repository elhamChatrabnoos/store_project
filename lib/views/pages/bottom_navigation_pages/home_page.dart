import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/controllers/user_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/widgets/add_edit_category_dialog.dart';
import 'package:shop_getx/views/pages/all_product_list_page.dart';
import 'package:shop_getx/views/pages/product_details_page.dart';
import 'package:shop_getx/views/pages/user_info_page.dart';
import 'package:shop_getx/views/widgets/category_item.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/custom_text_field.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../../controllers/category_controller.dart';
import '../../../shared_class/custom_search.dart';

class HomePage extends GetView<CategoryController> {
  HomePage({Key? key}) : super(key: key);

  List<String> sliderImages = [
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg'
  ];

  bool isUserAdmin =
      AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoryController());
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: AppColors.grayColor,
            appBar: _appBarView(context),
            body: _bodyItems(context)));
  }

  AppBar _appBarView(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () => Get.to(() => const UserProfilePage()),
            icon: const Icon(Icons.account_circle, size: 30)),
        const Spacer(),
        IconButton(
          onPressed: () {
            // method to show the search bar
            showSearch(
              context: context,
              delegate: CustomSearchDelegate(),
              // delegate to customize the search bar
            );
          },
          icon: const Icon(
            Icons.search,
            size: 30,
          ),
        )
      ],
    );
  }

  Widget _bodyItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imagesSlider(),
            AppSizes.normalSizeBox2,
            _addNewCategory(),
            AppSizes.littleSizeBox,
            _listOfCategories(),
            // AppSizes.normalSizeBox,
            _categoryTitle('کالاهای اساسی'),
            _productOfCategories(context),
            AppSizes.bigSizeBox,
          ],
        ),
      ),
    );
  }

  Widget _addNewCategory() {
    return UserController.getUserFromPref()['userId'] == 1
        ? TextButton(
            onPressed: () {
              Get.dialog(AddEditCategoryDialog(isActionEdit: false));
            },
            child: const Text('افزودن دسته بندی'))
        : const CustomText(text: 'دسته بندی ها');
  }

  Widget _listOfCategories() {
    return GetBuilder<CategoryController>(
      assignId: true,
      builder: (cateController) {
        return GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
          ),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              onDeleteClick: () =>
                  cateController.deleteCategory(categoryList[index]),
              showEdit: isUserAdmin,
              onEditClick: () {
                _showEditDialog(cateController, index);
              },
              text: categoryList[index].name!,
              onTapItem: () => _goProductsPage(index),
            );
          },
        );
      },
    );
  }

  Future<dynamic>? _goProductsPage(int index) {
    return Get.to(() => AllProductListPage(
          categoryList[index].productsList ?? [],
          categoryList[index].name!,
        ));
  }

  void _showEditDialog(CategoryController cateController, int index) {
    cateController.categoryName.text = categoryList[index].name!;
    Get.dialog(AddEditCategoryDialog(
      isActionEdit: true,
      categoryIndex: index,
      targetCategory: categoryList[index],
    ));
  }

  Widget _categoryTitle(String categoryTitle) {
    return Row(
      children: [
        CustomText(
            text: categoryTitle, textSize: 20, textWeight: FontWeight.bold),
        const Spacer(),
        InkWell(
          onTap: () {
            // Get.to(() => AllProductListPage());
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
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: ListView.builder(
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
        ));
    // );
  }

  Widget _moreButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        // onTap: () => Get.to(() => AllProductListPage()),
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
}
