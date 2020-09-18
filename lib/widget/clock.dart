import 'package:flutter/material.dart';
import 'dart:async';

class Clock extends StatefulWidget {

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _timeString;

  @override
  void initState() {
    _timeString = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    setState(() {
      _timeString = '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_timeString);
  }
}