part of 'update_status_bimbingan_bloc.dart';

@freezed
class UpdateStatusBimbinganEvent with _$UpdateStatusBimbinganEvent {
  const factory UpdateStatusBimbinganEvent.started() = _Started;
  const factory UpdateStatusBimbinganEvent.updateStatus(
      {required int? id, required String status}) = _UpdateStatus;
}
