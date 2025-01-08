part of 'get_project_bloc.dart';

@freezed
class GetProjectState with _$GetProjectState {
  const factory GetProjectState.initial() = _Initial;
  const factory GetProjectState.loading() = _Loading;
  const factory GetProjectState.success(List<Project> projects) = _Success;
  const factory GetProjectState.error(String message) = _Error;
}
