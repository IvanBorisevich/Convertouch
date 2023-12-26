import 'package:convertouch/domain/constants/constants.dart';
import 'package:convertouch/domain/model/input/units_events.dart';
import 'package:convertouch/domain/model/output/units_states.dart';
import 'package:convertouch/domain/usecases/units/add_unit_use_case.dart';
import 'package:convertouch/domain/usecases/units/fetch_units_use_case.dart';
import 'package:convertouch/domain/usecases/units/remove_units_use_case.dart';
import 'package:convertouch/presentation/bloc/abstract_bloc.dart';

class UnitsBloc extends ConvertouchBloc<UnitsEvent, UnitsState> {
  final AddUnitUseCase addUnitUseCase;
  final FetchUnitsUseCase fetchUnitsUseCase;
  final RemoveUnitsUseCase removeUnitsUseCase;

  UnitsBloc({
    required this.addUnitUseCase,
    required this.fetchUnitsUseCase,
    required this.removeUnitsUseCase,
  }) : super(const UnitsFetched(unitGroup: null));

  @override
  Stream<UnitsState> mapEventToState(UnitsEvent event) async* {
    yield const UnitsFetching();

    if (event is FetchUnits) {
      final result = await fetchUnitsUseCase.execute(event);

      if (result.isLeft) {
        yield UnitsErrorState(
          message: result.left.message,
        );
      } else {
        if (event is FetchUnitsToMarkForRemoval) {
          List<int> markedIds = [];

          if (event.alreadyMarkedIds.isNotEmpty) {
            markedIds = event.alreadyMarkedIds;
          }

          if (!markedIds.contains(event.newMarkedId)) {
            markedIds.add(event.newMarkedId);
          } else {
            markedIds.remove(event.newMarkedId);
          }

          yield UnitsFetched(
            units: result.right,
            unitGroup: event.unitGroup,
            searchString: event.searchString,
            removalMode: true,
            markedIdsForRemoval: markedIds,
          );
        } else {
          yield UnitsFetched(
            units: result.right,
            unitGroup: event.unitGroup,
            searchString: event.searchString,
            removedIds: event.removedIds,
            addedId: event.addedId,
          );
        }
      }
    } else if (event is AddUnit) {
      final addUnitResult = await addUnitUseCase.execute(event);

      if (addUnitResult.isLeft) {
        yield UnitsErrorState(
          message: addUnitResult.left.message,
        );
      } else {
        int addedUnitId = addUnitResult.right;

        if (addedUnitId != -1) {
          add(
            FetchUnits(
              unitGroup: event.unitGroup,
              searchString: null,
              addedId: addedUnitId,
            ),
          );
        } else {
          yield UnitExists(
            unitName: event.newUnit.name,
          );
        }
      }
    } else if (event is RemoveUnits) {
      final result = await removeUnitsUseCase.execute(event);
      if (result.isLeft) {
        yield UnitsErrorState(
          message: result.left.message,
        );
      } else {
        add(
          FetchUnits(
            unitGroup: event.unitGroup,
            searchString: null,
            removedIds: event.ids,
          ),
        );
      }
    } else if (event is DisableUnitsRemovalMode) {
      add(
        FetchUnits(
          unitGroup: event.unitGroup,
          searchString: null,
        ),
      );
    }
  }
}
