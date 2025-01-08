part of 'get_project_bloc.dart';

@freezed
class GetProjectEvent with _$GetProjectEvent {
  const factory GetProjectEvent.started() = _Started;
  const factory GetProjectEvent.getProject() = _GetProject;
}