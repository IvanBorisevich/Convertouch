import 'package:convertouch/domain/model/unit_group_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/presentation/bloc/abstract_event.dart';

abstract class UnitsEvent extends ConvertouchEvent {
  const UnitsEvent();
}

class FetchUnits extends UnitsEvent {
  final UnitGroupModel unitGroup;
  final String? searchString;

  const FetchUnits({
    required this.unitGroup,
    this.searchString,
  });

  @override
  List<Object?> get props => [
        unitGroup,
        searchString,
      ];

  @override
  String toString() {
    return 'FetchUnits{'
        'unitGroup: $unitGroup, '
        'searchString: $searchString}';
  }
}

class SaveUnit extends UnitsEvent {
  final UnitModel unit;
  final UnitGroupModel unitGroup;
  final bool unitGroupChanged;

  const SaveUnit({
    required this.unit,
    required this.unitGroup,
    required this.unitGroupChanged,
  });

  @override
  List<Object?> get props => [
        unit,
        unitGroup,
        unitGroupChanged,
      ];

  @override
  String toString() {
    return 'SaveUnit{'
        'unit: $unit, '
        'unitGroupChanged: $unitGroupChanged}';
  }
}

class RemoveUnits extends UnitsEvent {
  final List<int> ids;
  final UnitGroupModel unitGroup;

  const RemoveUnits({
    required this.ids,
    required this.unitGroup,
  });

  @override
  List<Object?> get props => [
        ids,
        unitGroup,
      ];

  @override
  String toString() {
    return 'RemoveUnits{'
        'ids: $ids, '
        'unitGroup: $unitGroup}';
  }
}

class ModifyUnit extends UnitsEvent {
  final UnitModel modifiedUnit;

  const ModifyUnit({
    required this.modifiedUnit,
  });

  @override
  List<Object?> get props => [
        modifiedUnit,
      ];

  @override
  String toString() {
    return 'ModifyUnit{modifiedUnit: $modifiedUnit}';
  }
}

class ModifyGroup extends UnitsEvent {
  final UnitGroupModel modifiedGroup;

  const ModifyGroup({
    required this.modifiedGroup,
  });

  @override
  List<Object?> get props => [
        modifiedGroup,
      ];

  @override
  String toString() {
    return 'ModifyGroup{modifiedGroup: $modifiedGroup}';
  }
}
