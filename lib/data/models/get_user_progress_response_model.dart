import 'dart:convert';

class GetUserProgressResponseModel {
    final int? status;
    final String? message;
    final List<ProgressKelompok>? data;

    GetUserProgressResponseModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetUserProgressResponseModel.fromJson(String str) => GetUserProgressResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory GetUserProgressResponseModel.fromMap(Map<String, dynamic> json) => GetUserProgressResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<ProgressKelompok>.from(json["data"]!.map((x) => ProgressKelompok.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}


class ProgressKelompok {
    final int? internshipId;
    final String? leaderName;
    final String? projectName;
    final List<Progress>? progress;

    ProgressKelompok({
        this.internshipId,
        this.leaderName,
        this.projectName,
        this.progress,
    });

    factory ProgressKelompok.fromJson(String str) => ProgressKelompok.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ProgressKelompok.fromMap(Map<String, dynamic> json) => ProgressKelompok(
        internshipId: json["internship_id"],
        leaderName: json["leader_name"],
        projectName: json["project_name"],
        progress: json["progress"] == null ? [] : List<Progress>.from(json["progress"]!.map((x) => Progress.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "internship_id": internshipId,
        "leader_name": leaderName,
        "project_name": projectName,
        "progress": progress == null ? [] : List<dynamic>.from(progress!.map((x) => x.toMap())),
    };
}

class Progress {
    final int? id;
    final String? meeting;
    final DateTime? date;
    final String? fileUrl;
    final String? name;

    Progress({
        this.id,
        this.meeting,
        this.date,
        this.fileUrl,
        this.name,
    });

    factory Progress.fromJson(String str) => Progress.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Progress.fromMap(Map<String, dynamic> json) => Progress(
        id: json["id"],
        meeting: json["meeting"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        fileUrl: json["file_url"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "meeting": meeting,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "file_url": fileUrl,
        "name": name,
    };
}
