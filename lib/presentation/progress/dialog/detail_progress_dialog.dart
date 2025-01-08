import 'package:flutter/material.dart';

class DetailProgressDialog extends StatefulWidget {
  final String namaPeserta;
  final String pertemuanMagang;
  final String projectNama;
  final String tanggalBimbingan;
  final String progressAnda;
  const DetailProgressDialog(
      {super.key,
      required this.namaPeserta,
      required this.pertemuanMagang,
      required this.projectNama,
      required this.tanggalBimbingan,
      required this.progressAnda});

  @override
  State<DetailProgressDialog> createState() => _DetailProgressDialogState();
}

class _DetailProgressDialogState extends State<DetailProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Stack(
        children: [
          const Text('Progress Peserta'),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Nama Peserta'),
            subtitle: Text(widget.namaPeserta),
          ),
          ListTile(
            title: const Text('Pertemuan Ke'),
            subtitle: Text(widget.pertemuanMagang),
          ),
          ListTile(
            title: const Text('Tanggal Bimbingan'),
            subtitle: Text(widget.tanggalBimbingan),
          ),
          ListTile(
            title: const Text('Progress Anda'),
            subtitle: Text(widget.progressAnda),
          ),
        ],
      ),
    );
  }
}
