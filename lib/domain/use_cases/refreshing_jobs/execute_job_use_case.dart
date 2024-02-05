import 'dart:async';
import 'dart:developer';

import 'package:convertouch/domain/model/exception_model.dart';
import 'package:convertouch/domain/model/refreshing_job_model.dart';
import 'package:convertouch/domain/model/refreshing_job_result_model.dart';
import 'package:convertouch/domain/model/use_case_model/input/input_conversion_rebuild_model.dart';
import 'package:convertouch/domain/model/use_case_model/input/input_start_job_model.dart';
import 'package:convertouch/domain/model/use_case_model/output/output_conversion_model.dart';
import 'package:convertouch/domain/repositories/network_data_repository.dart';
import 'package:convertouch/domain/use_cases/conversion/rebuild_conversion_use_case.dart';
import 'package:convertouch/domain/use_cases/use_case.dart';
import 'package:convertouch/domain/utils/object_utils.dart';
import 'package:either_dart/either.dart';
import 'package:rxdart/rxdart.dart';

class ExecuteJobUseCase
    extends UseCase<InputExecuteJobModel, RefreshingJobModel> {
  final NetworkDataRepository networkDataRepository;
  final RebuildConversionUseCase rebuildConversionUseCase;

  const ExecuteJobUseCase({
    required this.networkDataRepository,
    required this.rebuildConversionUseCase,
  });

  @override
  Future<Either<ConvertouchException, RefreshingJobModel>> execute(
    InputExecuteJobModel input,
  ) async {
    StreamController<RefreshingJobResultModel>? jobProgressController;

    try {
      if (input.job.selectedDataSource == null) {
        return const Left(
          InternalException(
            message: "No data source found for the job",
            severity: ExceptionSeverity.info,
          ),
        );
      }

      final isConnectionAvailable = ObjectUtils.tryGet(
        await networkDataRepository.isConnectionAvailable(),
      );

      if (!isConnectionAvailable) {
        return const Left(
          InternalException(
            message: "Please check an internet connection",
            severity: ExceptionSeverity.info,
          ),
        );
      }

      jobProgressController = createJobProgressStream(
        jobFunc: (jobProgressController) async {
          if (!jobProgressController.isClosed) {
            jobProgressController.add(const RefreshingJobResultModel.start());
          } else {
            log("On start: stream controller is already closed");
          }

          final refreshedData = ObjectUtils.tryGet(
            await networkDataRepository.refreshForGroup(
              unitGroupName: input.job.unitGroupName,
              dataSource: input.job.selectedDataSource!,
              refreshableDataPart: input.job.refreshableDataPart,
            ),
          );

          OutputConversionModel? rebuiltConversion;

          if (input.conversionToBeRebuilt != null) {
            rebuiltConversion = ObjectUtils.tryGet(
              await rebuildConversionUseCase.execute(
                InputConversionRebuildModel(
                  conversionToBeRebuilt: input.conversionToBeRebuilt!,
                  refreshableDataPart: input.job.refreshableDataPart,
                  refreshedData: refreshedData,
                ),
              ),
            );
          }

          if (!jobProgressController.isClosed) {
            log("Add finish result to the stream");
            jobProgressController.add(
              RefreshingJobResultModel.finish(
                rebuiltConversion: rebuiltConversion,
              ),
            );
          } else {
            log("At finish: stream controller is already closed");
          }
        },
      );

      return Right(
        RefreshingJobModel.coalesce(
          input.job,
          progressController: jobProgressController,
        ),
      );
    } catch (e) {
      log("Closing the stream from use case");
      jobProgressController?.close();

      return Left(
        InternalException(
          message: "Error when starting the refreshing job "
              "'${input.job.name}': $e",
        ),
      );
    }
  }

  StreamController<RefreshingJobResultModel> createJobProgressStream({
    required Future<void> Function(StreamController<RefreshingJobResultModel>)
        jobFunc,
  }) {
    late final BehaviorSubject<RefreshingJobResultModel> jobProgressController;
    jobProgressController = BehaviorSubject<RefreshingJobResultModel>(
      onListen: () async {
        try {
          await jobFunc.call(jobProgressController).whenComplete(() {
            if (!jobProgressController.isClosed) {
              log("Closing the stream after when job completed");
              jobProgressController.close();
            } else {
              log("After finish: stream controller is already closed");
            }
          });
        } catch (e) {
          log("Closing the stream when error during job execution: $e");
          await jobProgressController.close();
        }
      },
    );

    return jobProgressController;
  }
}
