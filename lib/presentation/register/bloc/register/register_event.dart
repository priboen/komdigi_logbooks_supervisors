part of 'register_bloc.dart';

@freezed
class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.started() = _Started;
  const factory RegisterEvent.register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    required XFile? photo,
  }) = _Register;
}