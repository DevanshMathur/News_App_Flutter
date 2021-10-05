import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeEvent extends Equatable {
  final ThemeData themeData;
  const ThemeEvent({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
