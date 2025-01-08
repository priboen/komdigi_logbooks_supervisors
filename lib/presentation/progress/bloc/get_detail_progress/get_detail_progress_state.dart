part of 'get_detail_progress_bloc.dart';

@freezed
class GetDetailProgressState with _$GetDetailProgressState {
  const factory GetDetailProgressState.initial() = _Initial;
  const factory GetDetailProgressState.loading() = _Loading;
  const factory GetDetailProgressState.success(List<DetailProgress> detailProgress) = _Success;
  const factory GetDetailProgressState.error(String message) = _Error;
}
