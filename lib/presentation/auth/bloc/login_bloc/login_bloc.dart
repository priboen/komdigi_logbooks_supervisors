import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_remote_datasource.dart';
import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource datasource;
  LoginBloc(this.datasource) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      final result = await datasource.login(event.email, event.password);
      result.fold((error) => emit(_Error(error)), (data) {
        AuthLocalDatasource().saveAuthData(data);
        emit(_Success(data));
      });
    });
  }
}
