part of 'get_detail_progress_bloc.dart';

@freezed
class GetDetailProgressEvent with _$GetDetailProgressEvent {
  const factory GetDetailProgressEvent.started() = _Started;
  const factory GetDetailProgressEvent.getDetailProgress(int? id) = _GetDetailProgress;
}