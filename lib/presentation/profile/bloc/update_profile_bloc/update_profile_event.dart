part of 'update_profile_bloc.dart';

@freezed
class UpdateProfileEvent with _$UpdateProfileEvent {
  const factory UpdateProfileEvent.started() = _Started;
  const factory UpdateProfileEvent.updateProfile({
    required int? id,
    required String name,
    required String email,
    required String password,
    required String phone,
    required XFile? photo,
  }) = _UpdateProfile;
}