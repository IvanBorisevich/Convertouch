import 'package:convertouch/view/style/colors.dart';
import 'package:flutter/material.dart';

class ConvertouchItemColors {
  const ConvertouchItemColors({
    this.borderColor = noColor,
    this.borderColorMarked = noColor,
    this.borderColorSelected = noColor,
    this.backgroundColor = noColor,
    this.backgroundColorMarked = noColor,
    this.backgroundColorSelected = noColor,
    this.contentColor = noColor,
    this.contentColorMarked = noColor,
    this.contentColorSelected = noColor,
  });

  final Color borderColor;
  final Color borderColorMarked;
  final Color borderColorSelected;
  final Color backgroundColor;
  final Color backgroundColorMarked;
  final Color backgroundColorSelected;
  final Color contentColor;
  final Color contentColorMarked;
  final Color contentColorSelected;
}