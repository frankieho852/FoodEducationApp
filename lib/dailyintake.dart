import 'package:flutter/material.dart';

class DailyIntake {
  final String nutrient;
  final double minDaily=0;
  final double minSametype,maxSametype;
  final double recDaily;

  DailyIntake({
    this.nutrient,
    this.minSametype,
    this.maxSametype,
    this.recDaily,
  });
}