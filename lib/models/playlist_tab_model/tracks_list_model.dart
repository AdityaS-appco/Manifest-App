class TracksListModel {
  String? message;
  List<Data>? data;
  List<String>? tagList;

  TracksListModel({this.message, this.data, this.tagList});

  TracksListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    tagList = json['tagList'].cast<String>();
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? tags;
  String? createdAt;
  String? updatedAt;
  int? affirmationsCount;

  Data(
      {this.id,
        this.name,
        this.image,
        this.tags,
        this.createdAt,
        this.updatedAt,
        this.affirmationsCount});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    tags = json['tags'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affirmationsCount = json['affirmations_count'];
  }

}