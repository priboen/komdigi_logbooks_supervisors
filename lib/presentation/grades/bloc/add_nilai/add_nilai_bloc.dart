import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/grade_remote_datasources.dart';

part 'add_nilai_event.dart';
part 'add_nilai_state.dart';
part 'add_nilai_bloc.freezed.dart';

class AddNilaiBloc extends Bloc<AddNilaiEvent, AddNilaiState> {
  final GradeRemoteDatasources datasources;
  AddNilaiBloc(this.datasources) : super(const _Initial()) {
    on<_AddNilai>(
      (event, emit) async {
        emit(const _Loading());
        if (event.id == null) {
          emit(const _Error('ID magang tidak boleh kosong.'));
          return;
        }
        final result =
            await datasources.addNilai(id: event.id!, nilai: event.nilai);
        result.fold(
          (l) => emit(_Error(l)),
          (r) => emit(const _Success()),
        );
      },
    );
  }
}
