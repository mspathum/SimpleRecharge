import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  CustomImage(
      {required this.height, required this.width, required this.imgPath});

  final double height;
  final double width;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(this.imgPath), fit: BoxFit.cover),
      ),
    );
  }
}
