import 'package:convertouch/domain/model/use_case_model/input/input_cron_change_model.dart';
import 'package:convertouch/domain/use_cases/refreshing_jobs/change_job_cron_use_case.dart';
import 'package:convertouch/domain/use_cases/refreshing_jobs/get_job_details_use_case.dart';
import 'package:convertouch/presentation/bloc/abstract_bloc.dart';
import 'package:convertouch/presentation/bloc/refreshing_job_details_page/refreshing_job_details_event.dart';
import 'package:convertouch/presentation/bloc/refreshing_job_details_page/refreshing_job_details_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshingJobDetailsBloc extends ConvertouchBloc<
    RefreshingJobDetailsEvent, RefreshingJobDetailsState> {
  final GetJobDetailsUseCase getJobDetailsUseCase;
  final ChangeJobCronUseCase changeJobCronUseCase;

  RefreshingJobDetailsBloc({
    required this.getJobDetailsUseCase,
    required this.changeJobCronUseCase,
  }) : super(const RefreshingJobDetailsInitialState()) {
    on<OpenJobDetails>(_onJobDetailsOpen);
    on<SelectAutoRefreshCron>(_onAutoRefreshCronSelect);
    on<SelectDataSource>(_onDataSourceSelect);
  }

  _onJobDetailsOpen(
    OpenJobDetails event,
    Emitter<RefreshingJobDetailsState> emit,
  ) async {
    final result = await getJobDetailsUseCase.execute(event.job);

    emit(
      result.fold(
        (left) => RefreshingJobDetailsErrorState(
          exception: left,
          lastSuccessfulState: state
        ),
        (jobDetails) => RefreshingJobDetailsReady(
          job: jobDetails.job,
        ),
      ),
    );
  }

  _onAutoRefreshCronSelect(
    SelectAutoRefreshCron event,
    Emitter<RefreshingJobDetailsState> emit,
  ) async {
    final result = await changeJobCronUseCase.execute(
      InputCronChangeModel(
        job: event.job,
        newCron: event.newCron,
      ),
    );

    emit(
      result.fold(
        (left) => RefreshingJobDetailsErrorState(
          exception: left,
          lastSuccessfulState: state,
        ),
        (job) => RefreshingJobDetailsReady(
          job: job,
        ),
      ),
    );
  }

  _onDataSourceSelect(
    SelectDataSource event,
    Emitter<RefreshingJobDetailsState> emit,
  ) async {}
}
