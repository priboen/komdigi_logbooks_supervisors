part of 'add_nilai_bloc.dart';

@freezed
class AddNilaiEvent with _$AddNilaiEvent {
  const factory AddNilaiEvent.started() = _Started;
  const factory AddNilaiEvent.addNilai({
    required int? id,
    required File nilai,
  }) = _AddNilai;
}