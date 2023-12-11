import 'package:convertouch/domain/model/failure.dart';
import 'package:convertouch/domain/model/input/units_events.dart';
import 'package:convertouch/domain/model/unit_model.dart';
import 'package:convertouch/domain/repositories/unit_repository.dart';
import 'package:convertouch/domain/usecases/use_case.dart';
import 'package:either_dart/either.dart';

class FetchUnitsOfGroupUseCase extends UseCase<FetchUnits, List<UnitModel>> {
  final UnitRepository unitRepository;

  const FetchUnitsOfGroupUseCase(this.unitRepository);

  @override
  Future<Either<Failure, List<UnitModel>>> execute({
    required FetchUnits input,
  }) async {
    return await unitRepository.fetchUnitsOfGroup(
      input.unitGroup.id!,
      searchString: input.searchString,
    );
  }
}
