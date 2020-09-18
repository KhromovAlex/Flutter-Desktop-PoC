import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToggleActiveSlider extends StatefulWidget {
  final Widget child;
  final Function handle;
  ToggleActiveSlider({this.child, this.handle});

  @override
  _ToggleActiveSliderState createState() => _ToggleActiveSliderState();
}

class _ToggleActiveSliderState extends State<ToggleActiveSlider> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (value) {
        RawKeyEventData data = value.data;
        // print(value is RawKeyUpEvent);
        if (value is RawKeyUpEvent && data.keyLabel == 'ArrowUp') {
          print('вверх');
          widget.handle(-1);
        }
        if (value is RawKeyUpEvent && data.keyLabel == 'ArrowDown') {
          print('вниз');
          widget.handle(1);
        }
      },
      child: Container(
        child: widget.child,
      ),
    );
  }
}
