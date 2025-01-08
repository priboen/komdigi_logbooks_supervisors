import 'dart:convert';

import 'package:komdigi_logbooks_supervisors/data/models/auth_response_model.dart';

class RegisterResponseModel {
    final String? message;
    final User? data;

    RegisterResponseModel({
        this.message,
        this.data,
    });

    RegisterResponseModel copyWith({
        String? message,
        User? data,
    }) => 
        RegisterResponseModel(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory RegisterResponseModel.fromJson(String str) => RegisterResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RegisterResponseModel.fromMap(Map<String, dynamic> json) => RegisterResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : User.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
    };
}