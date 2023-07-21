import 'package:convertouch/model/entity/unit_group_model.dart';
import 'package:convertouch/model/entity/unit_model.dart';
import 'package:convertouch/presenter/events/base_event.dart';

abstract class UnitsConversionEvent extends ConvertouchEvent {
  const UnitsConversionEvent();
}

class InitializeConversion extends UnitsConversionEvent {
  const InitializeConversion({
    this.inputValue = "1",
    this.inputUnitId = 0,
    required this.targetUnitIds,
    required this.unitGroup
  });

  final String inputValue;
  final int inputUnitId;
  final List<int> targetUnitIds;
  final UnitGroupModel unitGroup;

  @override
  List<Object> get props => [
    inputValue,
    inputUnitId,
    targetUnitIds,
    unitGroup,
  ];

  @override
  String toString() {
    return 'InitializeConversion{'
        'inputValue: $inputValue, '
        'inputUnitId: $inputUnitId, '
        'targetUnitIds: $targetUnitIds, '
        'unitGroup: $unitGroup}';
  }
}

class ConvertUnitValue extends UnitsConversionEvent {
  const ConvertUnitValue({
    required this.inputValue,
    required this.inputUnitId,
    required this.targetUnits,
  });

  final String inputValue;
  final int inputUnitId;
  final List<UnitModel> targetUnits;

  @override
  List<Object> get props => [
    inputValue,
    inputUnitId,
    targetUnits,
  ];

  @override
  String toString() {
    return 'ConvertUnitValue{'
        'inputValue: $inputValue, '
        'inputUnitId: $inputUnitId, '
        'targetUnitIds: $targetUnits}';
  }
}
