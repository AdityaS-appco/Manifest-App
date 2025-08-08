class RecordingsListModel {
  String? message;
  List<RecordingsListModelData>? data;

  RecordingsListModel({this.message, this.data});

  RecordingsListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RecordingsListModelData>[];
      json['data'].forEach((v) {
        data!.add(RecordingsListModelData.fromJson(v));
      });
    }
  }
}

class RecordingsListModelData {
  int? id;
  String? description;
  String? file;
  int? userId;
  String? deviceId;
  String? createdAt;
  String? updatedAt;
  int? affirmationsCount;
  String? totalDuration;
  List<Affirmations>? affirmations;

  RecordingsListModelData(
      {this.id,
        this.description,
        this.file,
        this.userId,
        this.deviceId,
        this.createdAt,
        this.updatedAt,
        this.affirmationsCount,
        this.totalDuration,
        this.affirmations});

  RecordingsListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    file = json['file'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affirmationsCount = json['affirmations_count'];
    totalDuration = json['total_duration'];
    if (json['affirmations'] != null) {
      affirmations = <Affirmations>[];
      json['affirmations'].forEach((v) {
        affirmations!.add(Affirmations.fromJson(v));
      });
    }
  }
}

class Affirmations {
  int? id;
  int? userId;
  String? deviceId;
  int? byYouContentId;
  String? description;
  String? file;
  String? createdAt;
  String? updatedAt;

  Affirmations(
      {this.id,
        this.userId,
        this.deviceId,
        this.byYouContentId,
        this.description,
        this.file,
        this.createdAt,
        this.updatedAt});

  Affirmations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    byYouContentId = json['by_you_content_id'];
    description = json['description'];
    file = json['file'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}