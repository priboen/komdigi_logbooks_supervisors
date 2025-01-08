import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:komdigi_logbooks_supervisors/core/constants/colors.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/presentation/grades/bloc/add_nilai/add_nilai_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/main_page.dart';

class UploadGradesPages extends StatefulWidget {
  final int? internshipId;
  const UploadGradesPages({super.key, this.internshipId});

  @override
  State<UploadGradesPages> createState() => _UploadGradesPagesState();
}

class _UploadGradesPagesState extends State<UploadGradesPages> {
  String? uploadedFileName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Nilai'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['pdf'],
                      );
                      if (result != null && result.files.isNotEmpty) {
                        setState(
                          () {
                            uploadedFileName = result.files.single.path;
                          },
                        );
                      }
                    },
                    child: const Text('Upload'),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      uploadedFileName ?? 'Belum ada file',
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SpaceHeight(32.0),
              BlocConsumer<AddNilaiBloc, AddNilaiState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berhasil mengupload nilai'),
                        ),
                      );
                      context.pushReplacement(const MainPage());
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppColors.red,
                        ),
                      );
                      print(message);
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                        onPressed: () {
                          if (uploadedFileName == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Harap upload semua file yang diperlukan'),
                              ),
                            );
                            return;
                          }
                          final letterFile = File(uploadedFileName!);
                          if (!letterFile.existsSync()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'File tidak ditemukan. Harap pilih ulang file.'),
                              ),
                            );
                            return;
                          }
                          context.read<AddNilaiBloc>().add(
                                AddNilaiEvent.addNilai(
                                  id: widget.internshipId!,
                                  nilai: letterFile,
                                ),
                              );
                        },
                        label: 'Simpan',
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
