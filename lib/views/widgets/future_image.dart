import 'dart:typed_data';

import 'package:flutter/material.dart';

class FutureImage extends StatelessWidget {
  const FutureImage({Key? key, required this.future}) : super(key: key);

  final Future<Uint8List?> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Image.memory(snapshot.data!, width: 100, height: 100);
        }
        else{
          return CircularProgressIndicator();
        }
      },);;
  }
}
