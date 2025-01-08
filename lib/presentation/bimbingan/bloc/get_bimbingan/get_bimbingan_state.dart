part of 'get_bimbingan_bloc.dart';

@freezed
class GetBimbinganState with _$GetBimbinganState {
  const factory GetBimbinganState.initial() = _Initial;
  const factory GetBimbinganState.loading() = _Loading;
  const factory GetBimbinganState.loaded(List<Bimbingan> bimbingan) = _Loaded;
  const factory GetBimbinganState.error(String message) = _Error;
}
