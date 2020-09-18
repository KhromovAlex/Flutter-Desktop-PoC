import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_desktop_poc/model/slide_model.dart';
import 'package:flutter_desktop_poc/widget/custom_slider_item.dart';

class CustomSlider extends StatefulWidget {
  final String title;
  final List<SlideModel> listSlides;
  final bool active;
  CustomSlider({@required this.title, @required this.listSlides, this.active = false});

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  int indexActiveSlide = 0;
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollCtrl = ScrollController();
  bool animatedFinished = true;

  @override
  Widget build(BuildContext context) {
    if (widget.active == true) {
      FocusScope.of(context).requestFocus(_focusNode);
    }

    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (value) {
        RawKeyEventData data = value.data;
        // print(data.logicalKey.keyId);
        if (value is RawKeyUpEvent && data.logicalKey.keyId == 4295426128 && animatedFinished == true) {
          int newActiveIndex = indexActiveSlide == 0 ? 0 : indexActiveSlide - 1;
          setState(() {
            animatedFinished = false;
            indexActiveSlide = newActiveIndex;
          });
          _scrollCtrl.animateTo(_scrollCtrl.offset - 155, duration: Duration(milliseconds: 500), curve: Curves.linear).then((value) {
            setState(() {
              animatedFinished = true;
            });
          });
        }
        if (value is RawKeyUpEvent && data.logicalKey.keyId == 4295426127 && animatedFinished == true) {
          int newActiveIndex = indexActiveSlide + 1 >= widget.listSlides.length ? widget.listSlides.length - 1 : indexActiveSlide + 1;
          setState(() {
            animatedFinished = false;
            indexActiveSlide = newActiveIndex;
          });
          _scrollCtrl.animateTo(_scrollCtrl.offset + 155, duration: Duration(milliseconds: 500), curve: Curves.linear).then((value) {
            setState(() {
              animatedFinished = true;
            });
          });
        }
      },
      child: Container(
        height: 240,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Container(
              height: 200,
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                controller: _scrollCtrl,
                scrollDirection: Axis.horizontal,
                itemCount: widget.listSlides.length,
                itemBuilder: (context, index) {
                  return CustomSliderItem(
                    active: indexActiveSlide == index && widget.active == true ? true : false,
                    title: widget.listSlides[index].title,
                    bgImage: widget.listSlides[index].image,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 20,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
