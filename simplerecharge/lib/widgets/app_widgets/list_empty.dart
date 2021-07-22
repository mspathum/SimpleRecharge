import 'package:flutter/material.dart';
import 'package:simplerecharge/widgets/app_widgets/custom_image.dart';

class ListEmptyImage extends StatelessWidget {
  ListEmptyImage(this.title, this.description);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: CustomImage(
                height: 200.0,
                width: 200.0,
                imgPath: "assets/images/no_data.png"),
          ),
          Container(
              child: Text(this.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500))),
          SizedBox(height: 5.0),
          Container(
              child: Text(this.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0, color: Colors.black))),
        ],
      ),
    );
  }
}
