import 'package:flutter/material.dart';

class CustomSliderItem extends StatelessWidget {
  final bool active;
  final String title;
  final NetworkImage bgImage;
  final Color colorBorder;

  CustomSliderItem({this.active = false, @required this.title, @required this.bgImage, this.colorBorder = Colors.blueAccent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      height: 200,
      decoration: BoxDecoration(
        border: active == true
            ? Border.all(
                color: colorBorder,
                width: 5,
              )
            : null,
        image: DecorationImage(fit: BoxFit.cover, image: bgImage),
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
