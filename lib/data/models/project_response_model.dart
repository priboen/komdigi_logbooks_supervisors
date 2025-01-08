import 'dart:convert';

import 'package:komdigi_logbooks_supervisors/data/models/internship_response_model.dart';

class ProjectResponseModel {
  final String? message;
  final List<Project>? data;

  ProjectResponseModel({
    this.message,
    this.data,
  });

  factory ProjectResponseModel.fromJson(String str) =>
      ProjectResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProjectResponseModel.fromMap(Map<String, dynamic> json) =>
      ProjectResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<Project>.from(json["data"].map((x) => Project.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data":
            data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
      };
}
