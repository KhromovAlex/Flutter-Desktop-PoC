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

  HomeBloc({@required int countSliders}) : _countSliders = countSliders {
    mainScrollCtrl.addListener(() {
      if (mainScrollCtrl.position.pixels <= 500) {
        double onePerc = 500 / 100;
        double opacity = 1 - (mainScrollCtrl.position.pixels / onePerc / 100);
        double scale = 1 + 0.002 * mainScrollCtrl.position.pixels / onePerc;
        _opacitySubject.add(opacity);
        _scaleSubject.add(scale);
      }
    });
  }

  ScrollController mainScrollCtrl = ScrollController();

  Stream<int> get streamCurrentSlider => _currentSliderSubject.stream;
  Stream<double> get streamOpacity => _opacitySubject.stream;
  Stream<double> get streamScale => _scaleSubject.stream;

  void setCurrentSlider(int count) {

    int newIndexSlider = _currentSlider + count;

    if (newIndexSlider >= _countSliders || newIndexSlider < -1) return;

    if (newIndexSlider == -1) {
      mainScrollCtrl.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.linear);
    } else if (_currentSlider > newIndexSlider) {
      mainScrollCtrl.animateTo(newIndexSlider.toDouble() * 256, duration: Duration(milliseconds: 500), curve: Curves.linear);
    } else if (_currentSlider < newIndexSlider) {
      mainScrollCtrl.animateTo(newIndexSlider.toDouble() * 256, duration: Duration(milliseconds: 500), curve: Curves.linear);
    }

    _currentSlider = newIndexSlider;

    _currentSliderSubject.add(_currentSlider);
  }

  void backToTop() {
    mainScrollCtrl.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.linear);
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
