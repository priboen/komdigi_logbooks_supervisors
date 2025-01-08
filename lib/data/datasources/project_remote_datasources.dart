import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_supervisors/core/constants/variables.dart';
import 'package:komdigi_logbooks_supervisors/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_supervisors/data/models/project_response_model.dart';

class ProjectRemoteDatasources {
  Future<Either<String, ProjectResponseModel>> getProject() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/projects');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(ProjectResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }
}
