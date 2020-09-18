import 'package:flutter/material.dart';
import 'dart:math';

class PromoSection extends StatelessWidget {
  final NetworkImage image;
  final String title;
  final String description;
  final double opacity;
  final double scale;

  PromoSection({this.image, this.title, this.description, this.opacity, this.scale});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(scale, scale),
      child: Opacity(
        opacity: opacity,
        child: Container(
          padding: EdgeInsets.all(16),
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 20,
              ),
              FractionallySizedBox(
                widthFactor: .5,
                child: Text(description),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                color: Colors.grey,
                child: Text(
                  'Read More',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
