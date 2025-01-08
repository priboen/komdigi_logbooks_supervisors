import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/progress_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/detail_progress_response_model.dart';

part 'get_detail_progress_event.dart';
part 'get_detail_progress_state.dart';
part 'get_detail_progress_bloc.freezed.dart';

class GetDetailProgressBloc extends Bloc<GetDetailProgressEvent, GetDetailProgressState> {
  final ProgressRemoteDatasources datasources;
  GetDetailProgressBloc(this.datasources) : super(const _Initial()) {
    on<_GetDetailProgress>((event, emit) async {
      emit(const _Loading());
      final result = await datasources.getProgressByUserId(id: event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data ?? [])),
      );
    });
  }
}
