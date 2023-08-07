import 'package:convertouch/model/entity/unit_value_model.dart';
import 'package:convertouch/view/items_view/item/item.dart';
import 'package:convertouch/view/items_view/item_view_mode/unit_value_list_item.dart';
import 'package:convertouch/view/style/model/conversion_item_colors.dart';
import 'package:flutter/material.dart';

class ConvertouchConversionItem extends ConvertouchItem {
  ConvertouchConversionItem(
    this.unitValue,
    ConvertouchItem baseItem,
    this.conversionColors,
  ) : super.fromItem(baseItem);

  final UnitValueModel unitValue;
  final ConvertouchConversionItemColors conversionColors;

  @override
  Widget buildForGrid() {
    throw UnimplementedError();
  }

  @override
  Widget buildForList() {
    return ConvertouchUnitValueListItem(
      unitValue,
      onTap: onTap,
      onLongPress: onLongPress,
      onValueChanged: onValueChanged,
      itemColors: conversionColors,
    );
  }
}
