import 'package:convertouch/presentation/bloc/abstract_state.dart';
import 'package:convertouch/domain/model/unit_group_model.dart';
import 'package:convertouch/domain/model/unit_model.dart';

abstract class UnitCreationState extends ConvertouchState {
  const UnitCreationState();
}

class UnitCreationPreparing extends UnitCreationState {
  const UnitCreationPreparing();

  @override
  String toString() {
    return 'UnitCreationPreparing{}';
  }
}

class UnitCreationPrepared extends UnitCreationState {
  final UnitGroupModel? unitGroup;
  final UnitModel? baseUnit;
  final String? comment;

  const UnitCreationPrepared({
    required this.unitGroup,
    required this.baseUnit,
    this.comment,
  });

  @override
  List<Object?> get props => [
    unitGroup,
    baseUnit,
    comment,
  ];

  @override
  String toString() {
    return 'UnitCreationPrepared{'
        'unitGroup: $unitGroup, '
        'baseUnit: $baseUnit, '
        'comment: $comment}';
  }
}

class UnitCreationErrorState extends ConvertouchErrorState
    implements UnitCreationState {
  const UnitCreationErrorState({
    required super.exception,
    required super.lastSuccessfulState,
  });

  @override
  String toString() {
    return 'UnitCreationErrorState{'
        'exception: $exception}';
  }
}
