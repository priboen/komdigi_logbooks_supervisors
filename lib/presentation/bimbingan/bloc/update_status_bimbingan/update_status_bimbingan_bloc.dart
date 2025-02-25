import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/internship_remote_datasources.dart';

part 'update_status_bimbingan_event.dart';
part 'update_status_bimbingan_state.dart';
part 'update_status_bimbingan_bloc.freezed.dart';

class UpdateStatusBimbinganBloc extends Bloc<UpdateStatusBimbinganEvent, UpdateStatusBimbinganState> {
  final InternshipRemoteDatasources datasource;
  UpdateStatusBimbinganBloc(this.datasource) : super(const _Initial()) {
    on<_UpdateStatus>((event, emit)async {
      emit(const _Loading());
      final result = await datasource.updateStatus(event.id, event.status);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
