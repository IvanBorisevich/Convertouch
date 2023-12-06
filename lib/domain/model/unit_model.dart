import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/item_model.dart';

class UnitModel extends IdNameItemModel {
  const UnitModel({
    int? id,
    required String name,
    this.coefficient,
    required this.abbreviation,
    required this.unitGroupId,
  }) : super(
          id: id,
          name: name,
          itemType: ItemType.unit,
        );

  final double? coefficient;
  final String abbreviation;
  final int unitGroupId;

  @override
  List<Object?> get props => [
    id,
    name,
    itemType,
    coefficient,
    abbreviation,
    unitGroupId,
  ];

  @override
  String toString() {
    return 'UnitModel{$name, c=$coefficient}';
  }
}
