part of 'update_status_bimbingan_bloc.dart';

@freezed
class UpdateStatusBimbinganState with _$UpdateStatusBimbinganState {
  const factory UpdateStatusBimbinganState.initial() = _Initial;
  const factory UpdateStatusBimbinganState.loading() = _Loading;
  const factory UpdateStatusBimbinganState.success() = _Success;
  const factory UpdateStatusBimbinganState.error(String message) = _Error;

}
