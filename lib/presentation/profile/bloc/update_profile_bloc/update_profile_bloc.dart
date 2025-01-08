import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_remote_datasource.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';
part 'update_profile_bloc.freezed.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final AuthRemoteDatasource datasource;
  UpdateProfileBloc(this.datasource) : super(const _Initial()) {
    on<_UpdateProfile>((event, emit) async {
      if (event.name.isEmpty || event.email.isEmpty || event.phone.isEmpty) {
        emit(const _Error(error: "All fields are required."));
        return;
      }
      emit(const _Loading());
      final result = await datasource.updateProfile(
        event.id,
        event.name,
        event.email,
        event.password,
        event.phone,
        event.photo,
      );
      await result.fold(
        (l) async {
          emit(_Error(error: l));
        },
        (r) async {
          await AuthLocalDatasource().updateAuthData(r);
          emit(const _Success());
        },
      );
    });
  }
}
