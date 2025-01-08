part of 'get_progress_bloc.dart';

@freezed
class GetProgressState with _$GetProgressState {
  const factory GetProgressState.initial() = _Initial;
  const factory GetProgressState.loading() = _Loading;
  const factory GetProgressState.success(List<ProgressKelompok> progress) = _Success;
  const factory GetProgressState.error(String message) = _Error;
}
