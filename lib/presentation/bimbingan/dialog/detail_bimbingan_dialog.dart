import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_supervisors/core/extensions/extensions.dart';

class DetailBimbinganDialog extends StatefulWidget {
  final String namaPeserta;
  final String namaProject;
  // final String namaKampus;
  final String tglPertemuan;
  const DetailBimbinganDialog(
      {super.key,
      required this.namaPeserta,
      required this.namaProject,
      // required this.namaKampus,
      required this.tglPertemuan,});

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
        children: [
          ListTile(
            title: const Text(
              'Nama Peserta',
            ),
            subtitle: Text(widget.namaPeserta),
          ),
          ListTile(
            title: const Text(
              'Nama Project',
            ),
            subtitle: Text(widget.namaPeserta),
          ),
          // ListTile(
          //   title: const Text(
          //     'Nama Kampus',
          //   ),
          //   subtitle: Text(widget.namaKampus),
          // ),
          ListTile(
            title: const Text(
              'Tanggal Pertemuan',
            ),
            subtitle: Text(widget.tglPertemuan),
            leading: const Icon(Icons.calendar_today),
          ),
          // ListTile(
          //   title: const Text(
          //     'Durasi',
          //   ),
          //   subtitle: Text(widget.jumlahDurasi),
          // ),
          // ListTile(
          //   title: const Text(
          //     'Interval',
          //   ),
          //   subtitle: Text(widget.jumlahInterval),
          // ),
        ],
      ),
    );
  }
}
