import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BehaviorSubject<int> _currentSliderSubject = BehaviorSubject<int>();
  final BehaviorSubject<bool> _animatedFinishedSubject = BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<double> _opacitySubject = BehaviorSubject<double>.seeded(1);
  final BehaviorSubject<double> _scaleSubject = BehaviorSubject<double>.seeded(1);
  final int _countSliders;
  int _currentSlider = -1;
  double _scrollTop = 0;
  // bool _animatedFinished = true;

  HomeBloc({@required int countSliders}) : _countSliders = countSliders {
    mainScrollCtrl.addListener(() {
      if (mainScrollCtrl.position.pixels <= 500) {
        double onePerc = 500 / 100;
        double opacity = 1 - (mainScrollCtrl.position.pixels / onePerc / 100);
        double scale = 1 + 0.002 * mainScrollCtrl.position.pixels / onePerc;
        _opacitySubject.add(opacity);
        _scaleSubject.add(scale);
      }
      // mainScrollCtrl.addListener(() {
      //   mainScrollCtrl.position.hold(() {});
      // });
    });
  }

  ScrollController mainScrollCtrl = ScrollController();

  Stream<int> get streamCurrentSlider => _currentSliderSubject.stream;
  Stream<double> get streamOpacity => _opacitySubject.stream;
  Stream<double> get streamScale => _scaleSubject.stream;
  // Stream<bool> get streamAnimatedFinished => _animatedFinishedSubject.stream;

  // void toggleAnimatedFinished() {
  //   _animatedFinished = !_animatedFinished;
  //   _animatedFinishedSubject.add(_animatedFinished);
  // }

  void setCurrentSlider(int count) {
    // if (_animatedFinished == false) return;

    int newIndexSlider = _currentSlider + count;

    if (newIndexSlider >= _countSliders || newIndexSlider < -1) return;

    print(_currentSlider);
    print(newIndexSlider);

    if (newIndexSlider == -1) {
      // _animatedFinished = false;
      // WidgetsBinding.instance.addPostFrameCallback((dur) {
      mainScrollCtrl.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
      // });
    } else if (_currentSlider > newIndexSlider) {
      // _animatedFinished = false;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      mainScrollCtrl.animateTo(mainScrollCtrl.offset - 256, duration: Duration(milliseconds: 500), curve: Curves.linear);
      // });
    } else if (_currentSlider < newIndexSlider) {
      // _animatedFinished = false;
      // WidgetsBinding.instance.addPostFrameCallback((_) {
      mainScrollCtrl.animateTo(mainScrollCtrl.offset + 256, duration: Duration(milliseconds: 500), curve: Curves.linear);
      // });
    }

    _currentSlider = newIndexSlider;

    _currentSliderSubject.add(_currentSlider);
  }

  void backToTop() {
    // WidgetsBinding.instance.addPostFrameCallback(() {
    mainScrollCtrl.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.linear);
    // }
    _currentSlider = -1;
    _currentSliderSubject.add(_currentSlider);
  }

  dispose() {
    _currentSliderSubject.close();
    _opacitySubject.close();
    _scaleSubject.close();
    _animatedFinishedSubject.close();
  }
}
