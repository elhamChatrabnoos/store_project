import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  ProductItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.price,
      required this.image,
        this.discount})
      : super(key: key);

  String title;
  String description;
  int price;
  final int? discount;
  String image;


  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    width: 100,
                    height: 100,
                  )),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child:  Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(discount.toString() + '%',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)))),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      price.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15,
                          color: Color.fromARGB(255, 180, 180, 180)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Text(price.toString() + ' تومان')
            ],
          ),
        ));
  }
}
