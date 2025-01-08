import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_supervisors/core/constants/variables.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/add_nilai_response_model.dart';

class GradeRemoteDatasources {
  Future<Either<String, AddNilaiResponseModel>> addNilai({
    required int id,
    required File nilai,
  }) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final headers = {
        'Authorization': 'Bearer ${authData?.token}',
      };

      final url = Uri.parse('${Variables.baseUrl}/api/grades/upload');
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['internship_id'] = id.toString() // Nama field sesuai dengan backend
        ..files.add(
          await http.MultipartFile.fromPath(
            'grade_file', // Nama field sesuai dengan backend
            nilai.path,
          ),
        );

      final response = await request.send();
      final body = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return Right(AddNilaiResponseModel.fromJson(body));
      } else {
        final error = _extractErrorMessage(body);
        return Left(error ?? 'Terjadi kesalahan saat mengunggah nilai.');
      }
    } catch (e) {
      return Left('Kesalahan jaringan: $e');
    }
  }

  // Fungsi untuk mengekstrak pesan error dari respons backend
  String? _extractErrorMessage(String responseBody) {
    try {
      final Map<String, dynamic> json = jsonDecode(responseBody);
      return json['message'];
    } catch (_) {
      return null;
    }
  }
}
