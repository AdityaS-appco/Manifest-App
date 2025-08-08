class FavoritePlaylistModel {
  String? message;
  int? totalAffirmations;
  String? totalDuration;
  List<Data>? data;

  FavoritePlaylistModel(
      {this.message, this.totalAffirmations, this.totalDuration, this.data});

  FavoritePlaylistModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalAffirmations = json['total_affirmations'];
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
  int? categoryId;
  String? categoryName;
  int? subCategoryId;
  String? subCategoryName;
  String? title;
  String? description;
  String? affirmationImage;
  String? tags;
  bool? isFavorite;
  String? audio;
  String? image;
  String? audioDuration;
  List<TypesOfVoices>? typesOfVoices;

  Data(
      {this.id,
        this.categoryId,
        this.categoryName,
        this.subCategoryId,
        this.subCategoryName,
        this.title,
        this.description,
        this.affirmationImage,
        this.tags,
        this.isFavorite,
        this.audio,
        this.image,
        this.audioDuration,
        this.typesOfVoices});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    subCategoryId = json['sub_category_id'];
    subCategoryName = json['sub_category_name'];
    title = json['title'];
    description = json['description'];
    affirmationImage = json['affirmationImage'];
    tags = json['tags'];
    isFavorite = json['is_favorite'];
    audio = json['audio'];
    image = json['image'];
    audioDuration = json['audio_duration'];
    if (json['types_of_voices'] != null) {
      typesOfVoices = <TypesOfVoices>[];
      json['types_of_voices'].forEach((v) {
        typesOfVoices!.add(TypesOfVoices.fromJson(v));
      });
    }
  }
}

class TypesOfVoices {
  int? id;
  String? name;
  String? image;
  String? music;

  TypesOfVoices({this.id, this.name, this.image, this.music});

  TypesOfVoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    music = json['music'];
  }
}