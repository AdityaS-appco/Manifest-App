class HiddenAffirmationResponseModel {
  final String? message;
  final int? totalAffirmations;
  final List<HiddenAffirmation>? data;

  HiddenAffirmationResponseModel({
    this.message,
    this.totalAffirmations,
    this.data,
  });

  factory HiddenAffirmationResponseModel.fromJson(Map<String, dynamic> json) =>
      HiddenAffirmationResponseModel(
        message: json["message"],
        totalAffirmations: json["total_affirmations"],
        data: json["data"] == null
            ? []
            : List<HiddenAffirmation>.from(
                json["data"]!.map((x) => HiddenAffirmation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "total_affirmations": totalAffirmations,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HiddenAffirmation {
  final int? id;
  final int? categoryId;
  final String? categoryName;
  final dynamic subCategoryId;
  final dynamic subCategoryName;
  final String? title;
  final String? description;
  final String? affirmationImage;
  final String? tags;
  final bool? isFavorite;
  final bool? isHidden;
  final String? audio;
  final String? image;
  final String? audioDuration;
  final List<dynamic>? typesOfVoices;

  HiddenAffirmation({
    this.id,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.title,
    this.description,
    this.affirmationImage,
    this.tags,
    this.isFavorite,
    this.isHidden,
    this.audio,
    this.image,
    this.audioDuration,
    this.typesOfVoices,
  });

  factory HiddenAffirmation.fromJson(Map<String, dynamic> json) =>
      HiddenAffirmation(
        id: json["id"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        subCategoryId: json["sub_category_id"],
        subCategoryName: json["sub_category_name"],
        title: json["title"],
        description: json["description"],
        affirmationImage: json["affirmation_image"],
        tags: json["tags"],
        isFavorite: json["is_favorite"],
        isHidden: json["is_hidden"],
        audio: json["audio"],
        image: json["image"],
        audioDuration: json["audio_duration"],
        typesOfVoices: json["types_of_voices"] == null
            ? []
            : List<dynamic>.from(json["types_of_voices"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "category_name": categoryName,
        "sub_category_id": subCategoryId,
        "sub_category_name": subCategoryName,
        "title": title,
        "description": description,
        "affirmation_image": affirmationImage,
        "tags": tags,
        "is_favorite": isFavorite,
        "is_hidden": isHidden,
        "audio": audio,
        "image": image,
        "audio_duration": audioDuration,
        "types_of_voices": typesOfVoices == null
            ? []
            : List<dynamic>.from(typesOfVoices!.map((x) => x)),
      };
}
