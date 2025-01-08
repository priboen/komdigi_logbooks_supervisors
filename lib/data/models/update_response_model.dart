import 'dart:convert';

import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';


class UpdateProfileResponseModel {
    final String? message;
    final User? user;

    UpdateProfileResponseModel({
        this.message,
        this.user,
    });

    factory UpdateProfileResponseModel.fromJson(String str) => UpdateProfileResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UpdateProfileResponseModel.fromMap(Map<String, dynamic> json) => UpdateProfileResponseModel(
        message: json["message"],
        user: json["user"] == null ? null : User.fromMap(json["user"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "user": user?.toMap(),
    };
    
}
