import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/internship_response_model.dart';

part 'get_bimbingan_event.dart';
part 'get_bimbingan_state.dart';
part 'get_bimbingan_bloc.freezed.dart';

class GetBimbinganBloc extends Bloc<GetBimbinganEvent, GetBimbinganState> {
  final InternshipRemoteDatasources datasource;
  GetBimbinganBloc(this.datasource) : super(const _Initial()) {
    on<_GetBimbingan>(
      (event, emit) async {
        emit(const _Loading());
        final result = await datasource.getInternship(event.id);
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Loaded(r.data ?? [])),
        );
      },
    );
  }
}
