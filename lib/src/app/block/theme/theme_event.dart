import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeEvent extends Equatable {
  final ThemeMode themeMode;
  const ThemeEvent({required this.themeMode});

  @override
  List<Object> get props => [themeMode];
}
