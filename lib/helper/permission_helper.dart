import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermissions(BuildContext context) async {
  // Request camera and storage permissions
  final cameraStatus = await Permission.camera.request();
  final storageStatus = await Permission.storage.request();

  // Log status izin
  debugPrint('Camera permission: ${cameraStatus.isGranted}');
  debugPrint('Storage permission: ${storageStatus.isGranted}');

  if (cameraStatus.isGranted && storageStatus.isGranted) {
    return true;
  }

  // Handle denied permissions
  if (cameraStatus.isDenied || storageStatus.isDenied) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Akses kamera atau penyimpanan ditolak.'),
        backgroundColor: Colors.red,
      ),
    );
  } else if (cameraStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
    _showSettingsDialog(context);
  }

  return false;
}

  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Izin Diperlukan'),
          content: const Text(
            'Akses kamera dan penyimpanan diperlukan untuk melanjutkan. Harap izinkan melalui pengaturan aplikasi.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings();
              },
              child: const Text('Pengaturan'),
            ),
          ],
        );
      },
    );
  }
}