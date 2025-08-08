// class RecordingsListModelByID {
//   String? message;
//   int? affirmationsCount;
//   String? totalDuration;
//   Data? data;

//   RecordingsListModelByID(
//       {this.message, this.affirmationsCount, this.totalDuration, this.data});

//   RecordingsListModelByID.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     affirmationsCount = json['affirmations_count'];
//     totalDuration = json['total_duration'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }

// class Data {
//   int? id;
//   String? description;
//   int? userId;
//   String? deviceId;
//   String? createdAt;
//   String? updatedAt;
//   List<Affirmations>? affirmations;

//   Data(
//       {this.id,
//         this.description,
//         this.userId,
//         this.deviceId,
//         this.createdAt,
//         this.updatedAt,
//         this.affirmations});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     description = json['description'];
//     userId = json['user_id'];
//     deviceId = json['device_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['affirmations'] != null) {
//       affirmations = <Affirmations>[];
//       json['affirmations'].forEach((v) {
//         affirmations!.add(Affirmations.fromJson(v));
//       });
//     }
//   }
// }

// class Affirmations {
//   int? id;
//   int? userId;
//   String? deviceId;
//   int? byYouContentId;
//   String? description;
//   String? file;
//   String? createdAt;
//   String? updatedAt;
//   String? fileDuration;

//   Affirmations(
//       {this.id,
//         this.userId,
//         this.deviceId,
//         this.byYouContentId,
//         this.description,
//         this.file,
//         this.createdAt,
//         this.updatedAt,
//         this.fileDuration});

//   Affirmations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     deviceId = json['device_id'];
//     byYouContentId = json['by_you_content_id'];
//     description = json['description'];
//     file = json['file'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     fileDuration = json['file_duration'];
//   }
// }


class RecordingsListModelByID {
    String? message;
    RecordingsListModelByIdData? data;

    RecordingsListModelByID({
        this.message,
        this.data,
    });

    RecordingsListModelByID copyWith({
        String? message,
        RecordingsListModelByIdData? data,
    }) => 
        RecordingsListModelByID(
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory RecordingsListModelByID.fromJson(Map<String, dynamic> json) => RecordingsListModelByID(
        message: json["message"],
        data: RecordingsListModelByIdData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class RecordingsListModelByIdData {
    int? affirmationsCount;
    DataData? data;

    RecordingsListModelByIdData({
        this.affirmationsCount,
        this.data,
    });

    RecordingsListModelByIdData copyWith({
        int? affirmationsCount,
        DataData? data,
    }) => 
        RecordingsListModelByIdData(
            affirmationsCount: affirmationsCount ?? this.affirmationsCount,
            data: data ?? this.data,
        );

    factory RecordingsListModelByIdData.fromJson(Map<String, dynamic> json) => RecordingsListModelByIdData(
        affirmationsCount: json["affirmations_count"],
        data: DataData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "affirmations_count": affirmationsCount,
        "data": data?.toJson(),
    };
}

class DataData {
    int? id;
    String? description;
    dynamic userId;
    String? deviceId;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Affirmation>? affirmations;

    DataData({
        this.id,
        this.description,
        this.userId,
        this.deviceId,
        this.createdAt,
        this.updatedAt,
        this.affirmations,
    });

    DataData copyWith({
        int? id,
        String? description,
        dynamic userId,
        String? deviceId,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<Affirmation>? affirmations,
    }) => 
        DataData(
            id: id ?? this.id,
            description: description ?? this.description,
            userId: userId ?? this.userId,
            deviceId: deviceId ?? this.deviceId,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            affirmations: affirmations ?? this.affirmations,
        );

    factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        id: json["id"],
        description: json["description"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        affirmations: List<Affirmation>.from(json["affirmations"].map((x) => Affirmation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "user_id": userId,
        "device_id": deviceId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "affirmations": List<dynamic>.from(affirmations?.map((x) => x.toJson()) ?? []),
    };
}

class Affirmation {
    int? id;
    int? userId;
    String? deviceId;
    int? byYouContentId;
    String? description;
    String? file;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? fileDuration;

    Affirmation({
        this.id,
        this.userId,
        this.deviceId,
        this.byYouContentId,
        this.description,
        this.file,
        this.createdAt,
        this.updatedAt,
        this.fileDuration,
    });

    Affirmation copyWith({
        int? id,
        int? userId,
        String? deviceId,
        int? byYouContentId,
        String? description,
        String? file,
        DateTime? createdAt,
        DateTime? updatedAt,
        String? fileDuration,
    }) => 
        Affirmation(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            deviceId: deviceId ?? this.deviceId,
            byYouContentId: byYouContentId ?? this.byYouContentId,
            description: description ?? this.description,
            file: file ?? this.file,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            fileDuration: fileDuration ?? this.fileDuration,
        );

    factory Affirmation.fromJson(Map<String, dynamic> json) => Affirmation(
        id: json["id"],
        userId: json["user_id"],
        deviceId: json["device_id"],
        byYouContentId: json["by_you_content_id"],
        description: json["description"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fileDuration: json["file_duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "device_id": deviceId,
        "by_you_content_id": byYouContentId,
        "description": description,
        "file": file,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "file_duration": fileDuration,
    };
}
