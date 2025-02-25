import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/extensions.dart';

class DetailBimbinganDialog extends StatefulWidget {
  final String namaPeserta;
  final List<String?> namaAnggota;
  final String namaProject;
  final String namaKampus;
  final String tglMulai;
  final String tglSelesai;
  final String periodeMagang;
  const DetailBimbinganDialog({
    super.key,
    required this.namaPeserta,
    required this.namaProject,
    required this.namaKampus,
    required this.tglMulai,
    required this.tglSelesai,
    required this.periodeMagang, required this.namaAnggota,
  });

  @override
  State<DetailBimbinganDialog> createState() => _DetailBimbinganDialogState();
}

class _DetailBimbinganDialogState extends State<DetailBimbinganDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        alignment: Alignment.centerLeft,
        children: [
          const Text(
            'Detail Peserta',
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
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text(
              'Nama Peserta',
            ),
            subtitle: Text(widget.namaPeserta),
          ),
          ListTile(
            title: const Text(
              'Anggota',
            ),
            subtitle: Text(widget.namaAnggota.join(', ')),
          ),
          ListTile(
            title: const Text(
              'Nama Project',
            ),
            subtitle: Text(widget.namaProject),
          ),
          ListTile(
            title: const Text(
              'Nama Kampus',
            ),
            subtitle: Text(widget.namaKampus),
          ),
          ListTile(
            title: const Text(
              'Tanggal Mulai',
            ),
            subtitle: Text(widget.tglMulai),
            leading: const Icon(Icons.calendar_today),
          ),
          ListTile(
            title: const Text(
              'Tanggal Selesai',
            ),
            subtitle: Text(widget.tglSelesai),
            leading: const Icon(Icons.calendar_today),
          ),
          ListTile(
            title: const Text(
              'Durasi',
            ),
            subtitle: Text(widget.periodeMagang),
          ),
        ],
      ),
    );
  }
}
