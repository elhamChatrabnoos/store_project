import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/shared/product_controller.dart';
import 'package:shop_getx/controllers/admin/tag_controller.dart';
import 'package:shop_getx/core/app_colors.dart';
import 'package:shop_getx/core/app_keys.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/generated/locales.g.dart';
import 'package:shop_getx/shared_class/shared_prefrences.dart';
import 'package:shop_getx/views/pages/all_product_list_page.dart';
import 'package:shop_getx/views/pages/user_info_page.dart';
import 'package:shop_getx/views/widgets/add_edit_category_dialog.dart';
import 'package:shop_getx/views/widgets/add_edit_tag_dialog.dart';
import 'package:shop_getx/views/widgets/category_item.dart';
import 'package:shop_getx/views/widgets/custom_button.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

import '../../../controllers/admin/category_controller.dart';
import '../../../controllers/client/user_controller.dart';
import '../../../shared_class/custom_search.dart';
import '../product_details_page.dart';

class HomePage extends GetView {
  HomePage({Key? key}) : super(key: key);

  List<String> sliderImages = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpg',
    'assets/images/slider3.jpg'
  ];

  bool isUserAdmin =
      AppSharedPreference.isUserAdminPref!.getBool(AppKeys.isUserAdmin)!;

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CategoryController());
    Get.lazyPut(() => TagController());

    return Scaffold(
        backgroundColor: AppColors.backGroundColor,
        appBar: _appBarView(context),
        body: _bodyItems(context));
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
            // AppSizes.littleSizeBox,
            _addTagText(),
            _listOfTags(),
            _imagesSlider(),
            AppSizes.normalSizeBox3,
            _addNewCategory(),
            // AppSizes.littleSizeBox,
            _listOfCategories(),
            _categoryTitle(LocaleKeys.HomePage_allProduct.tr),
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
                  logic.tagNameController.text = '';
                  Get.dialog(AddEditTagDialog(isActionEdit: false))
                      .then((value) {
                    logic.getTags();
                  });
                },
                child: Text(LocaleKeys.HomePage_addTagTxt.tr));
          })
        : const SizedBox();
  }

  Widget _listOfTags() {
    return SizedBox(
        height: 30,
        child: GetBuilder<TagController>(builder: (tagLogic) {
          return GetBuilder<CategoryController>(builder: (caLogic) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: tagsList.length,
              itemBuilder: (context, index) {
                return tagsList[index].id != 0
                    ? Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onLongPress: () async {
                            if (isUserAdmin) {
                              await _removeTag(index, caLogic, tagLogic);
                            }
                          },
                          onTap: () {
                            _showTagDialog(tagLogic, index);
                          },
                          child: CustomButton(
                            buttonColor: AppColors.backGroundColor,
                            borderColor: AppColors.darkGrayColor,
                            buttonText: tagsList[index].name!,
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            );
          });
        }));
  }

  void _showTagDialog(TagController tagLogic, int index) {
    if (isUserAdmin) {
      tagLogic.tagNameController.text = tagsList[index].name!;
      Get.dialog(AddEditTagDialog(
        tagIndex: index,
        isActionEdit: true,
        targetTag: tagsList[index],
      )).then((value) {
        tagLogic.getTags();
      });
    }
  }

  Future<void> _removeTag(
      int index, CategoryController caLogic, TagController taLogic) async {
    // remove tag from all categories product
    for (var category in categoryList) {
      for (var product in category.productsList!) {
        if (product.productTag == tagsList[index].name) {
          product.productTag = LocaleKeys.Add_product_page_withoutTag.tr;
          await caLogic.editCategory(category);
        }
      }
    }

    // remove tag from product list product
    for (var product in productList) {
      if (product.productTag == tagsList[index].name) {
        product.productTag = null;
        await productController.editProduct(product);
      }
    }
    await taLogic.removeTag(tagsList[index]);
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
                  text: LocaleKeys.HomePage_addCategoryTxt.tr,
                  textSize: AppSizes.normalTextSize2,
                ));
          })
        : CustomText(
            text: LocaleKeys.HomePage_categories.tr,
            textSize: AppSizes.normalTextSize2,
          );
  }

  Widget _listOfCategories() {
    return GetBuilder<CategoryController>(
      assignId: true,
      builder: (logic) {
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: isUserAdmin ? 0.6 : 0.8,
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
              text: LocaleKeys.HomePage_seeAllTxt.tr,
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
                      onLongPress: () => isUserAdmin
                          ? logic.deleteProduct(productList[index])
                          : null,
                      onItemClick: () {
                        !isUserAdmin
                            ? Get.to(() => ProductDetailsPage(
                                  product: productList[index],
                                ))
                            : null;
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
          children: [
            CustomText(
              textSize: 15,
              text: LocaleKeys.HomePage_allProduct.tr,
              textColor: Colors.lightBlueAccent,
              textWeight: FontWeight.normal,
            ),
            const Icon(
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
      itemCount: sliderImages.length,
      itemBuilder: (context, index, realIndex) {
        return Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(sliderImages[index]));
      },
      options: CarouselOptions(autoPlay: true),
    );
  }
}
