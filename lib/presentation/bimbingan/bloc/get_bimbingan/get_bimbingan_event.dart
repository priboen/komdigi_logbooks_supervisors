part of 'get_bimbingan_bloc.dart';

@freezed
class GetBimbinganEvent with _$GetBimbinganEvent {
  const factory GetBimbinganEvent.started() = _Started;
  const factory GetBimbinganEvent.getBimbingan({required int? id}) = _GetBimbingan;
}