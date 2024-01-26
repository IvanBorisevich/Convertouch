import 'package:convertouch/domain/model/use_case_model/input/input_unit_preparation_model.dart';
import 'package:convertouch/domain/use_cases/units/add_unit_use_case.dart';
import 'package:convertouch/domain/use_cases/units/prepare_unit_creation_use_case.dart';
import 'package:convertouch/presentation/bloc/abstract_bloc.dart';
import 'package:convertouch/presentation/bloc/unit_creation_page/unit_creation_events.dart';
import 'package:convertouch/presentation/bloc/unit_creation_page/unit_creation_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnitCreationBloc
    extends ConvertouchBloc<UnitCreationEvent, UnitCreationState> {
  final PrepareUnitCreationUseCase prepareUnitCreationUseCase;
  final AddUnitUseCase addUnitUseCase;

  UnitCreationBloc({
    required this.prepareUnitCreationUseCase,
    required this.addUnitUseCase,
  }) : super(
          const UnitCreationPrepared(
            unitGroup: null,
            baseUnit: null,
          ),
        ) {
    on<PrepareUnitCreation>(_onUnitCreationPrepare);
  }

  _onUnitCreationPrepare(
    PrepareUnitCreation event,
    Emitter<UnitCreationState> emit,
  ) async {
    emit(const UnitCreationPreparing());

    final result = await prepareUnitCreationUseCase.execute(
      InputUnitPreparationModel(
        baseUnit: event.baseUnit,
        unitGroup: event.unitGroup,
      ),
    );

    emit(
      result.fold(
        (error) => UnitCreationErrorState(
          exception: error,
          lastSuccessfulState: state,
        ),
        (outputUnitPreparationModel) => UnitCreationPrepared(
          unitGroup: outputUnitPreparationModel.unitGroup,
          baseUnit: outputUnitPreparationModel.baseUnit,
        ),
      ),
    );
  }
}
