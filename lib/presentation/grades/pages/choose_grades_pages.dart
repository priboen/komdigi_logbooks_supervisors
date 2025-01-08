import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/components/buttons.dart';
import 'package:komdigi_logbooks_supervisors/core/components/spaces.dart';
import 'package:komdigi_logbooks_supervisors/core/constants/colors.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_supervisors/presentation/bimbingan/bloc/get_bimbingan/get_bimbingan_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/grades/pages/upload_grades_pages.dart';

class ChooseGradesPages extends StatefulWidget {
  const ChooseGradesPages({super.key});

  @override
  State<ChooseGradesPages> createState() => _ChooseGradesPagesState();
}

class _ChooseGradesPagesState extends State<ChooseGradesPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Progress'),
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
                                    Button.filled(
                                      onPressed: () {
                                        context.push(UploadGradesPages(internshipId: bimbingan.id!));
                                      },
                                      label: 'Pilih',
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