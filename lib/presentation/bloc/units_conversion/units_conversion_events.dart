import 'package:convertouch/domain/model/unit_group_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/presentation/bloc/base_event.dart';

abstract class UnitsConversionEvent extends ConvertouchEvent {
  const UnitsConversionEvent();
}

class InitializeConversion extends UnitsConversionEvent {
  const InitializeConversion({
    this.inputValue,
    this.inputUnit,
    this.prevInputUnit,
    required this.conversionUnits,
    required this.unitGroup,
  });

  final double? inputValue;
  final UnitModel? inputUnit;
  final UnitModel? prevInputUnit;
  final List<UnitModel> conversionUnits;
  final UnitGroupModel unitGroup;

  @override
  List<Object> get props => [
    conversionUnits,
    unitGroup,
  ];

  @override
  String toString() {
    return 'InitializeConversion{'
        'inputValue: $inputValue, '
        'inputUnit: $inputUnit, '
        'prevInputUnit: $prevInputUnit, '
        'conversionUnits: $conversionUnits, '
        'unitGroup: $unitGroup}';
  }
}
