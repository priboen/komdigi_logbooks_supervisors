import 'dart:convert';

class AddNilaiResponseModel {
    final int? status;
    final String? message;
    final Nilai? data;

    AddNilaiResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory AddNilaiResponseModel.fromJson(String str) => AddNilaiResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AddNilaiResponseModel.fromMap(Map<String, dynamic> json) => AddNilaiResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Nilai.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data?.toMap(),
    };
}

class Nilai {
    final String? internshipId;
    final String? gradeUrl;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    Nilai({
        this.internshipId,
        this.gradeUrl,
        this.updatedAt,
        this.createdAt,
        this.id,
    });

    factory Nilai.fromJson(String str) => Nilai.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Nilai.fromMap(Map<String, dynamic> json) => Nilai(
        internshipId: json["internship_id"],
        gradeUrl: json["grade_url"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toMap() => {
        "internship_id": internshipId,
        "grade_url": gradeUrl,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };
}
