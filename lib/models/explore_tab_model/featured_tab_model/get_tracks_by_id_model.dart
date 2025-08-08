class TracksListResponseModel {
  String? message;
  Track? data;

  TracksListResponseModel({this.message, this.data});

  TracksListResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Track.fromJson(json['data']) : null;
  }
}

class Track {
  int? id;
  String? name;
  String? image;
  String? tags;
  String? file;
  var deviceId;
  var createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? trackDuration;
  int? affirmationsCount;
  String? totalAffirmationsDuration;
  List<Affirmation>? affirmations;

  Track(
      {this.id,
        this.name,
        this.image,
        this.tags,
        this.file,
        this.deviceId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.trackDuration,
        this.affirmationsCount,
        this.totalAffirmationsDuration,
        this.affirmations});

  Track.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    tags = json['tags'];
    file = json['file'];
    deviceId = json['device_id'];
    createdBy = json['created_by'];
    createdAt = DateTime.tryParse(json['created_at']);
    updatedAt = DateTime.tryParse(json['updated_at']);
    trackDuration = json['track_duration'].toString();
    affirmationsCount = json['affirmations_count'] as int?;
    totalAffirmationsDuration = json['total_affirmations_duration'];
    if (json['affirmations'] != null) {
      affirmations = <Affirmation>[];
      json['affirmations'].forEach((v) {
        affirmations!.add(Affirmation.fromJson(v));
      });
    }
  }
}

class Affirmation {
  int? id;
  String? description;
  String? image;
  String? subForm;
  String? affirmationsDuration;
  List<String>? trackAudio = [

  ];

  Affirmation(
      {this.id,
        this.description,
        this.image,
        this.subForm,
        this.trackAudio,
        this.affirmationsDuration});

  Affirmation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    subForm = json['sub_form'];
    affirmationsDuration = json['affirmations_duration'];
  }

}
