import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/constants/variables.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/date_time_ext.dart';
import 'package:komdigi_logbooks_supervisors/presentation/progress/bloc/get_detail_progress/get_detail_progress_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/progress/dialog/detail_progress_dialog.dart';

class ProgressDashboardPage extends StatefulWidget {
  final int internshipId;

  const ProgressDashboardPage({Key? key, required this.internshipId})
      : super(key: key);

  @override
  State<ProgressDashboardPage> createState() => _ProgressDashboardPageState();
}

class _ProgressDashboardPageState extends State<ProgressDashboardPage> {

  String generateFileUrl(String leaderEmail, String fileName) {
  // Format email untuk URL-friendly
  String formattedEmail = leaderEmail.replaceAll('@', '_').replaceAll('.', '_');
  return '$Variables/storage/internship/$formattedEmail/progress/$fileName';
}

  @override
  void initState() {
    // Trigger BLoC event untuk mengambil data progress berdasarkan internshipId
    context
        .read<GetDetailProgressBloc>()
        .add(GetDetailProgressEvent.getDetailProgress(widget.internshipId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Progress'),
      ),
      body: BlocBuilder<GetDetailProgressBloc, GetDetailProgressState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text(message)),
            success: (progressList) {
              if (progressList.isEmpty) {
                return const Center(child: Text('Tidak ada progress.'));
              }
              return ListView.builder(
                itemCount: progressList.length,
                itemBuilder: (context, index) {
                  final progress = progressList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Meeting ${progress.meeting}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            const Spacer(),
                            Button.filled(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DetailProgressDialog(
                                    namaPeserta: progress.leaderName ?? '',
                                    pertemuanMagang: progress.meeting ?? '',
                                    projectNama: progress.projectName ?? '',
                                    tanggalBimbingan:
                                        progress.date!.toFormattedDate(),
                                    progressAnda: progress.name ?? '',
                                  ),
                                );
                              },
                              label: 'Detail',
                              width: 100,
                              height: 30,
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.black,
                          thickness: 0.2,
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Nama:',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  progress.name ?? 'Tidak ada nama',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              progress.date!.toFormattedDate(),
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            orElse: () => const Center(child: Text('Loading...')),
          );
        },
      ),
    );
  }
}
