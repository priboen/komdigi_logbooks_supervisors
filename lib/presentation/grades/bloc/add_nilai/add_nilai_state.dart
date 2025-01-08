part of 'add_nilai_bloc.dart';

@freezed
class AddNilaiState with _$AddNilaiState {
  const factory AddNilaiState.initial() = _Initial;
  const factory AddNilaiState.loading() = _Loading;
  const factory AddNilaiState.success() = _Success;
  const factory AddNilaiState.error(String message) = _Error;
}
