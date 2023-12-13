import 'package:convertouch/domain/model/failure.dart';
import 'package:convertouch/domain/model/input/units_events.dart';
import 'package:convertouch/domain/repositories/unit_repository.dart';
import 'package:convertouch/domain/usecases/use_case.dart';
import 'package:either_dart/either.dart';

class RemoveUnitsUseCase extends UseCase<RemoveUnits, void> {
  final UnitRepository unitRepository;

  const RemoveUnitsUseCase(this.unitRepository);

  @override
  Future<Either<Failure, void>> execute(RemoveUnits input) async {
    return await unitRepository.removeUnits(input.ids);
  }
}
