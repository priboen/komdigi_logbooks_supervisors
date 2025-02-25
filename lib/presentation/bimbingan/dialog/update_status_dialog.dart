import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_supervisors/core/components/buttons.dart';
import 'package:komdigi_logbooks_supervisors/core/components/spaces.dart';
import 'package:komdigi_logbooks_supervisors/core/core.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_supervisors/presentation/bimbingan/bloc/update_status_bimbingan/update_status_bimbingan_bloc.dart';
import 'package:komdigi_logbooks_supervisors/presentation/main_page.dart';

class UpdateStatusDialog extends StatefulWidget {
  final int? id;
  const UpdateStatusDialog({super.key, required this.id});

  @override
  State<UpdateStatusDialog> createState() => _UpdateStatusDialogState();
}

class _UpdateStatusDialogState extends State<UpdateStatusDialog> {
  String? selectedStatus;
  final List<Map<String, String>> statusOptions = [
    {'label': 'Diterima', 'value': 'approved'},
    {'label': 'Ditolak', 'value': 'rejected'},
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Update Status',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.cancel,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: statusOptions.map((option) {
              return RadioListTile<String>(
                title: Text(option['label']!),
                value: option['value']!,
                groupValue: selectedStatus,
                onChanged: (String? value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
              );
            }).toList(),
          ),
          const SpaceHeight(32),
          BlocConsumer<UpdateStatusBimbinganBloc, UpdateStatusBimbinganState>(
            listener: (context, state) {
              state.maybeWhen(
                success: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil mengubah status'),
                      backgroundColor: AppColors.primary,
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
                },
                orElse: () {},
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                      onPressed: () {
                        if (selectedStatus != null) {
                          context.read<UpdateStatusBimbinganBloc>().add(
                                UpdateStatusBimbinganEvent.updateStatus(
                                  id: widget.id,
                                  status: selectedStatus!,
                                ),
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pilih status terlebih dahulu'),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        }
                      },
                      label: 'Simpan');
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
