import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_supervisors/core/constants/variables.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/internship_response_model.dart';

class InternshipRemoteDatasources {
  Future<Either<String, InternshipResponseModel>> getInternship(
    int? id,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    };
    final url = Uri.parse(
      '${Variables.baseUrl}/api/internships/supervisor/$id',
    );
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(
        InternshipResponseModel.fromJson(
          response.body,
        ),
      );
    } else {
      return Left(
        jsonDecode(response.body)['message'],
      );
    }
  }
}
