import 'package:flutter/material.dart';

enum Gender { male, female }

class NumerologyResult {
  final int driver;
  final int conductor;
  final int nameNumber;
  final int kuaNumber;
  final int personalYear;
  final Map<int, int> gridData;

  NumerologyResult({
    required this.driver,
    required this.conductor,
    required this.nameNumber,
    required this.kuaNumber,
    required this.personalYear,
    required this.gridData,
  });
}

class LuckyFactors {
  final List<Color> colors;
  final String colorNames;
  final String day;
  final String direction;

  LuckyFactors({
    required this.colors,
    required this.colorNames,
    required this.day,
    required this.direction,
  });
}
