class FavoriteTracksPlaylistModel {
  String? message;
  int? totalTracks;
  String? totalDuration;
  List<Data>? data;

  FavoriteTracksPlaylistModel(
      {this.message, this.totalTracks, this.totalDuration, this.data});

  FavoriteTracksPlaylistModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalTracks = json['total_tracks'];
    totalDuration = json['total_duration'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? tags;
  var deviceId;
  var createdBy;
  String? createdAt;
  String? updatedAt;
  var affirmationsCount;

  Data(
      {this.id,
        this.name,
        this.image,
        this.tags,
        this.deviceId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.affirmationsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    tags = json['tags'];
    deviceId = json['device_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affirmationsCount = json['affirmations_count'];
  }
}
