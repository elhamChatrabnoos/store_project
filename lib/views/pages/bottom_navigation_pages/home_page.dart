import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/product_controller.dart';
import 'package:shop_getx/controllers/tag_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/all_product_list_page.dart';
import 'package:shop_getx/views/pages/user_info_page.dart';
import 'package:shop_getx/views/widgets/add_edit_category_dialog.dart';
import 'package:shop_getx/views/widgets/add_edit_tag_dialog.dart';
import 'package:shop_getx/views/widgets/category_item.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../../controllers/category_controller.dart';
import '../../../shared_class/custom_search.dart';

class HomePage extends GetView {
  HomePage({Key? key}) : super(key: key);

  List<String> sliderImages = [
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg'
  ];

  bool isUserAdmin =
      AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;

  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => TagController());

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
              delegate: CustomSearchDelegate(targetList: productList),
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
            AppSizes.littleSizeBox,
            _addTagText(),
            _listOfTags(),
            _imagesSlider(),
            AppSizes.normalSizeBox2,
            _addNewCategory(),
            AppSizes.littleSizeBox,
            _listOfCategories(),
            _categoryTitle('همه محصولات'),
            _listOfProduct(context),
            AppSizes.bigSizeBox,
          ],
        ),
      ),
    );
  }

  Widget _addTagText() {
    return isUserAdmin
        ? GetBuilder<TagController>(builder: (logic) {
            return TextButton(
                onPressed: () {
                  logic.tagName.text = '';
                  Get.dialog(AddEditTagDialog(isActionEdit: false));
                },
                child: const Text('افزودن تگ'));
          })
        : const SizedBox();
  }

  Widget _listOfTags() {
    return SizedBox(
        height: 30,
        child: GetBuilder<TagController>(builder: (logic) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: tagsList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  onLongPress: () {
                    isUserAdmin ? logic.removeTag(tagsList[index]) : null;
                  },
                  onTap: () {
                    if (isUserAdmin) {
                      logic.tagName.text = tagsList[index].name!;
                      Get.dialog(AddEditTagDialog(
                        tagIndex: index,
                        isActionEdit: true,
                        targetTag: tagsList[index],
                      ));
                    }
                  },
                  child: CustomButton(
                    buttonColor: AppColors.grayColor,
                    borderColor: AppColors.darkGrayColor,
                    buttonText: tagsList[index].name ?? 'tag',
                  ),
                ),
              );
            },
          );
        }));
  }

  Widget _addNewCategory() {
    return isUserAdmin
        ? GetBuilder<CategoryController>(builder: (logic) {
            return TextButton(
                onPressed: () {
                  logic.categoryName.text = '';
                  Get.dialog(AddEditCategoryDialog(isActionEdit: false));
                },
                child: CustomText(
                  text: 'افزودن دسته بندی',
                  textSize: AppSizes.normalTextSize2,
                ));
          })
        : CustomText(
            text: 'دسته بندی ها',
            textSize: AppSizes.normalTextSize2,
          );
  }

  Widget _listOfCategories() {
    return GetBuilder<CategoryController>(
      assignId: true,
      builder: (logic) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.9,
          ),
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return CategoryItem(
              categoryImage: categoryList[index].image!,
              onDeleteClick: () {
                _deleteCategory(index, logic);
              },
              showEdit: isUserAdmin,
              onEditClick: () => _showEditDialog(index, logic),
              text: categoryList[index].name!,
              onTapItem: () => _goProductsPage(index),
            );
          },
        );
      },
    );
  }

  void _deleteCategory(int index, CategoryController controller) {
    for (var product in productList) {
      for (var categoryProduct in categoryList[index].productsList!) {
        if (product == categoryProduct) {
          // productController.deleteProduct(product);
        }
      }
    }
    controller.deleteCategory(categoryList[index]);
  }

  Future<dynamic>? _goProductsPage(int index) {
    return Get.to(() => AllProductListPage(categoryList[index]));
  }

  void _showEditDialog(int index, CategoryController catController) {
    catController.categoryName.text = categoryList[index].name!;
    Get.dialog(AddEditCategoryDialog(
      isActionEdit: true,
      targetCategory: categoryList[index],
    ));
  }

  Widget _categoryTitle(String categoryTitle) {
    return Row(
      children: [
        CustomText(
            text: categoryTitle,
            textSize: AppSizes.normalTextSize2,
            textWeight: FontWeight.bold),
        const Spacer(),
        InkWell(
          onTap: () {
            // Get.to(() => AllProductListPage());
          },
          child: CustomText(
              text: 'مشاهده همه',
              textColor: AppColors.buttonColor,
              textSize: AppSizes.normalTextSize2,
              textWeight: FontWeight.normal),
        )
      ],
    );
  }

  Widget _listOfProduct(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 2.5,
        child: GetBuilder<ProductController>(builder: (logic) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return index == 4
                  ? _moreButton()
                  : HomeProductItem(
                      onLongPress: () =>
                          isUserAdmin ? logic.deleteProduct(productList[index]) : null,
                      onItemClick: () {
                        // Get.to(() => ProductDetailsPage(
                        //       product: productList[index],
                        //     ));
                      },
                      product: productList[index],
                    );
            },
          );
        }));
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
