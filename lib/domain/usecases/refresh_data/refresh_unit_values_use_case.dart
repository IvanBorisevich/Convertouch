import 'package:convertouch/domain/model/failure.dart';
import 'package:convertouch/domain/model/refreshing_job_model.dart';
import 'package:convertouch/domain/model/usecases/output/output_job_result_model.dart';
import 'package:convertouch/domain/usecases/use_case.dart';
import 'package:either_dart/either.dart';

class RefreshUnitValuesUseCase extends ReactiveUseCase<RefreshingJobModel,
    OutputUnitValueRefreshingResult> {
  const RefreshUnitValuesUseCase();

  @override
  Either<Failure, Stream<OutputUnitValueRefreshingResult>> execute(
    RefreshingJobModel input,
  ) {
    return Right(
      Stream.value(
        const OutputUnitValueRefreshingResult(),
      ),
    );
  }
}
