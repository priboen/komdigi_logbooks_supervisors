import 'dart:convert';

class DetailProgressResponseModel {
    final int? status;
    final String? message;
    final List<DetailProgress>? data;

    DetailProgressResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory DetailProgressResponseModel.fromJson(String str) => DetailProgressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DetailProgressResponseModel.fromMap(Map<String, dynamic> json) => DetailProgressResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<DetailProgress>.from(json["data"]!.map((x) => DetailProgress.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class DetailProgress {
    final int? id;
    final String? meeting;
    final DateTime? date;
    final String? fileUrl;
    final String? name;
    final String? leaderName;
    final String? projectName;
    final String? supervisorName;

    DetailProgress({
        this.id,
        this.meeting,
        this.date,
        this.fileUrl,
        this.name,
        this.leaderName,
        this.projectName,
        this.supervisorName,
    });

    factory DetailProgress.fromJson(String str) => DetailProgress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory DetailProgress.fromMap(Map<String, dynamic> json) => DetailProgress(
        id: json["id"],
        meeting: json["meeting"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fileUrl: json["file_url"],
        name: json["name"],
        leaderName: json["leader_name"],
        projectName: json["project_name"],
        supervisorName: json["supervisor_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "meeting": meeting,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "file_url": fileUrl,
        "name": name,
        "leader_name": leaderName,
        "project_name": projectName,
        "supervisor_name": supervisorName,
    };
}
