part of 'get_progress_bloc.dart';

@freezed
class GetProgressEvent with _$GetProgressEvent {
  const factory GetProgressEvent.started() = _Started;
  const factory GetProgressEvent.getProgress() = _GetProgress;
}