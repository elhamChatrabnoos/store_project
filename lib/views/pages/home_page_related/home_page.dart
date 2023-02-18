import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_getx/controllers/home_page_controller.dart';
import 'package:shop_getx/core/app_sizes.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/custom_text_field.dart';
import 'package:shop_getx/views/widgets/home_poduct_item.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

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
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imagesSlider(),
            AppSizes.normalSizeBox2,
            _categoryTitle('شوینده ها'),
            _productCategories(),
            AppSizes.normalSizeBox2,
            _categoryTitle('حبوبات'),
            _productCategories(),
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
          onTap: () {},
          child: CustomText(
              text: 'مشاهده همه',
              textColor: Colors.blue,
              textSize: 17,
              textWeight: FontWeight.normal),
        )
      ],
    );
  }

  Widget _productCategories() {
    return Container(
        height: 270,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: false,
          itemCount: 5,
          itemBuilder: (context, index) {
            return index == 4
                ? _moreButton()
                : ProductItem(
                    image: 'assets/images/powder.png',
                    title: 'تاید لباسشویی',
                    description: '300 گرم',
                    price: 25000,
                    discount: 5);
          },
        ));
  }

  Widget _moreButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
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
    );
  }

  Widget _imagesSlider() {
    return CarouselSlider.builder(
        itemCount: 2,
        itemBuilder: (context, index, realIndex) {
          return Padding(
              padding: EdgeInsets.all(10),
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
