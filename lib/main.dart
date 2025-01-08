import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_remote_datasource.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/grade_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/progress_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/project_remote_datasources.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/bloc/login_bloc/login_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/bloc/logout_bloc/logout_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/pages/login_page.dart';
import 'package:komdigi_logbooks_supervisors/presentation/bimbingan/bloc/get_bimbingan/get_bimbingan_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/grades/bloc/add_nilai/add_nilai_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/profile/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/progress/bloc/get_detail_progress/get_detail_progress_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/progress/bloc/get_progress/get_progress_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/project/bloc/get_project/get_project_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/register/bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            AuthRemoteDatasource(),
          ),
        ),
        BlocProvider(
          create: (context) => GetBimbinganBloc(
            InternshipRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => GetProjectBloc(
            ProjectRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => GetProgressBloc(
            ProgressRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => GetDetailProgressBloc(
            ProgressRemoteDatasources(),
          ),
        ),
        BlocProvider(
          create: (context) => AddNilaiBloc(
            GradeRemoteDatasources(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.primary.withAlpha(128)),
          dialogTheme: const DialogTheme(elevation: 0),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.white),
            centerTitle: true,
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
