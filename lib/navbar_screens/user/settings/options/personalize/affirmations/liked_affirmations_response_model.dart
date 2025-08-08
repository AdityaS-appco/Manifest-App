class LikedAffirmationResponseModel {
  final String? message;
  final int? totalAffirmations;
  final List<LikedAffirmation>? data;

  LikedAffirmationResponseModel({
    this.message,
    this.totalAffirmations,
    this.data,
  });

  factory LikedAffirmationResponseModel.fromJson(Map<String, dynamic> json) {
    return LikedAffirmationResponseModel(
      message: json['message'],
      totalAffirmations: json['total_affirmations'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => LikedAffirmation.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'total_affirmations': totalAffirmations,
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class LikedAffirmation {
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

  LikedAffirmation({
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

  factory LikedAffirmation.fromJson(Map<String, dynamic> json) {
    return LikedAffirmation(
      id: json['id'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      subCategoryId: json['sub_category_id'],
      subCategoryName: json['sub_category_name'],
      title: json['title'],
      description: json['description'],
      affirmationImage: json['affirmation_image'],
      tags: json['tags'],
      isFavorite: json['is_favorite'],
      isHidden: json['is_hidden'],
      audio: json['audio'],
      image: json['image'],
      audioDuration: json['audio_duration'],
      typesOfVoices: json['types_of_voices'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id': categoryId,
      'category_name': categoryName,
      'sub_category_id': subCategoryId,
      'sub_category_name': subCategoryName,
      'title': title,
      'description': description,
      'affirmation_image': affirmationImage,
      'tags': tags,
      'is_favorite': isFavorite,
      'is_hidden': isHidden,
      'audio': audio,
      'image': image,
      'audio_duration': audioDuration,
      'types_of_voices': typesOfVoices,
    };
  }
}
