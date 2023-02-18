import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllProductListPage extends StatelessWidget {
  const AllProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _productList(),
    );
  }
}

Widget _productList() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {

    },
  );
}
