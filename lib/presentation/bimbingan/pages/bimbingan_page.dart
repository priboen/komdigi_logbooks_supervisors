import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/date_time_ext.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';
import 'package:komdigi_logbooks_supervisors/presentation/bimbingan/bloc/get_bimbingan/get_bimbingan_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/bimbingan/dialog/detail_bimbingan_dialog.dart';

class BimbinganPage extends StatefulWidget {
  const BimbinganPage({super.key});

  @override
  State<BimbinganPage> createState() => _BimbinganPageState();
}

class _BimbinganPageState extends State<BimbinganPage> {
  User? user;

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        print(user!.id);
      });
    }
    context
        .read<GetBimbinganBloc>()
        .add(GetBimbinganEvent.getBimbingan(id: user?.id));
  }

  @override
  void initState() {
    _loadUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Bimbingan'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BlocBuilder<GetBimbinganBloc, GetBimbinganState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (message) => Center(child: Text(message)),
                    loaded: (bimbinganList) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: bimbinganList.length,
                        itemBuilder: (context, index) {
                          final bimbingan = bimbinganList[index];
                          return Container(
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                top: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                left: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                                right: BorderSide(
                                  color: AppColors.gray2,
                                  width: 1.0,
                                ),
                              ),
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      bimbingan.leader?.name ??
                                          "Tidak ada nama",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    // Chip(
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius:
                                    //         BorderRadius.circular(32.0),
                                    //   ),
                                    //   side: const BorderSide(
                                    //     color: AppColors.primary,
                                    //     width: 1.0,
                                    //   ),
                                    //   label: const Text(
                                    //     'Detail',
                                    //   ),
                                    //   labelStyle: const TextStyle(
                                    //     color: AppColors.primary,
                                    //   ),
                                    // ),
                                    Button.filled(
                                      onPressed: () {
                                        context.push(DetailBimbinganDialog(
                                          namaPeserta: bimbingan.leader?.name ??
                                              "Tidak ada nama",
                                          namaProject:
                                              bimbingan.project?.name ?? '',
                                          tglPertemuan: bimbingan
                                              .leader!.createdAt!
                                              .toFormattedDate(),
                                        ));
                                      },
                                      label: 'Detail',
                                      width: 100,
                                      height: 35,
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: AppColors.gray2,
                                ),
                                const SpaceHeight(16.0),
                                const Text(
                                  'Project Yang Dipilih',
                                  style: TextStyle(color: AppColors.gray1),
                                ),
                                const SpaceHeight(8.0),
                                Text(
                                  bimbingan.project?.name ??
                                      "Tidak ada nama project",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SpaceHeight(32.0),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    orElse: () => const Center(child: Text("Tidak ada data")),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
