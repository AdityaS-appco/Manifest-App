class CreateOrUpdatePlaylist {
  String? message;
  Data? data;

  CreateOrUpdatePlaylist({this.message, this.data});

  CreateOrUpdatePlaylist.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? deviceId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? tracksCount;
  List<void>? tracks;

  Data(
      {this.id,
        this.name,
        this.image,
        this.deviceId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.tracksCount,
        this.tracks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    deviceId = json['device_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tracksCount = json['tracks_count'];

  }
}