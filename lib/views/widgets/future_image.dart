import 'dart:typed_data';

import 'package:flutter/material.dart';

class FutureImage extends StatelessWidget {
  const FutureImage({Key? key, required this.future, required this.imageSize}) : super(key: key);

  final Future<Uint8List?> future;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Image.memory(snapshot.data!, width: imageSize, height: imageSize);
        }
        else{
          return CircularProgressIndicator();
        }
      },);;
  }
}
