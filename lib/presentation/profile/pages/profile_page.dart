import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/bloc/logout_bloc/logout_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/auth/pages/login_page.dart';
import 'package:komdigi_logbooks_supervisors/presentation/profile/pages/update_profile_page.dart';
import 'package:komdigi_logbooks_supervisors/presentation/profile/widgets/menu_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  Future<void> _initializeUserData() async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      setState(() {
        user = authData?.user;
      });
    } catch (e) {
      print('Error fetching auth data: $e');
      setState(() {
        user = null;
      });
    }
  }

  @override
  void initState() {
    _initializeUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Assets.images.bgHome.provider(),
                fit: MediaQuery.of(context).size.width > 600
                    ? BoxFit.cover
                    : BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SpaceHeight(16),
                Center(
                  child: Column(
                    children: [
                      const SpaceHeight(210),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: user != null && user!.photo != null
                            ? NetworkImage(user!.photo!)
                            : Assets.images.avatar.provider(),
                      ),
                      const SpaceHeight(16),
                      Text(
                        user != null ? '${user!.name}' : 'User',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user != null ? '${user!.email}' : 'user@mail.com',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SpaceWidth(8),
                          Text(
                            '|',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          const SpaceWidth(8),
                          Text(
                            user != null ? '${user!.phone}' : 'Belum diatur',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SpaceHeight(16),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        "Account",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      const SpaceHeight(16),
                      MenuItem(
                        title: 'Ubah Profile',
                        icon: Icons.arrow_forward_ios,
                        onPressed: () {
                          context.push(const UpdateProfilePage());
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      BlocConsumer<LogoutBloc, LogoutState>(
                        listener: (context, state) {
                          state.maybeMap(
                            orElse: () {},
                            success: (_) {
                              context.pushReplacement(const LoginPage());
                            },
                            error: (value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(value.error),
                                  backgroundColor: AppColors.red,
                                ),
                              );
                            },
                          );
                        },
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return MenuItem(
                                title: 'Keluar',
                                icon: Icons.arrow_forward_ios,
                                onPressed: () {
                                  context.read<LogoutBloc>().add(
                                        const LogoutEvent.logout(),
                                      );
                                },
                              );
                            },
                            loading: () {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
