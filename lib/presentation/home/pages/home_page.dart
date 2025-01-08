import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_supervisors/core/assets/assets.gen.dart';
import 'package:komdigi_logbooks_supervisors/core/components/spaces.dart';
import 'package:komdigi_logbooks_supervisors/core/constants/colors.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';
import 'package:komdigi_logbooks_supervisors/presentation/grades/pages/choose_grades_pages.dart';
import 'package:komdigi_logbooks_supervisors/presentation/home/widgets/menu_button.dart';
import 'package:komdigi_logbooks_supervisors/presentation/project/pages/project_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  bool isLoading = false;

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        isLoading = false;
      });
    } else {
      setState(() {
        user = User(name: 'Guest', email: 'guest@example.com');
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Assets.images.bgHome.provider(),
              fit: MediaQuery.of(context).size.width > 600
                  ? BoxFit.cover
                  : BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hallo,",
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300),
                  ),
                  Text(
                    user?.name ?? 'Loading...',
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SpaceHeight(16.0),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.06),
                      blurRadius: 10.0,
                      blurStyle: BlurStyle.outer,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jadwal Terdekat Anda',
                      style: TextStyle(
                        color: AppColors.gray3,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Nama User',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      user?.name ?? 'Loading...',
                      style: const TextStyle(
                        color: AppColors.gray3,
                        fontSize: 12.0,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Email User',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      user?.email ?? 'Loading...',
                      style: const TextStyle(
                        color: AppColors.gray3,
                        fontSize: 12.0,
                      ),
                    ),
                    const SpaceHeight(16.0),
                    const Text(
                      'Nomor Handphone',
                      style: TextStyle(
                        color: AppColors.gray2,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      user?.phone ?? 'Loading...',
                      style: const TextStyle(
                        color: AppColors.gray3,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    MenuButton(
                      color: AppColors.homeGreen,
                      label: 'Lihat Project',
                      iconPath: Assets.icons.menu.jumlahPesanan.path,
                      onPressed: () {
                        context.push(const ProjectPages());
                      },
                    ),
                    MenuButton(
                      color: AppColors.homeYellow,
                      label: 'Nilai Akhir',
                      iconPath: Assets.icons.menu.transaksiHariIni.path,
                      onPressed: () {
                        context.push(const ChooseGradesPages());
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
