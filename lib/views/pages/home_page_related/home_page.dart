import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_getx/views/widgets/custom_product_item.dart';
import 'package:shop_getx/views/widgets/custom_text.dart';
import 'package:shop_getx/views/widgets/custom_text_field.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  List<Widget>? sliderImages = [
    Image.asset('assets/images/slider2.jpg'),
    Image.asset('assets/images/slider3.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(appBar: _appBarWithSearch(), body: _bodyItems()));
  }

  Widget _bodyItems() {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _imagesSlider(),
            const CustomText(
                text: 'شوینده ها', textSize: 20, fontWeight: FontWeight.bold),
            _productCategories()
          ],
        ),

    );
  }

  Widget _productCategories() {
    return Flexible(
        fit: FlexFit.tight,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return ProductItem(
                image: 'assets/images/powder.png',
                title: 'تاید لباسشویی',
                description: '300 گرم',
                price: 30000,
                discount: 5);
          },
        ));
  }

  Widget _imagesSlider() {
    return CarouselSlider.builder(
        itemCount: sliderImages!.length,
        itemBuilder: (context, index, realIndex) {
          return Card(
            child: sliderImages![index],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          );
        },
        options: CarouselOptions(autoPlay: false));
  }

  PreferredSize _appBarWithSearch() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: AppBar(
        flexibleSpace: Container(
            margin:
                const EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 10),
            child: CustomTextField(
              radius: 5,
              icon: const Icon(Icons.search),
              borderColor: Colors.deepPurpleAccent,
              hintText: 'جست و جوی محصول',
            )),
      ),
    );
  }
}
