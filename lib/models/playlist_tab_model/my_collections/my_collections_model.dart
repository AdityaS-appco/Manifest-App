import 'package:manifest/core/utils/helpers.dart';

class CollectionResponseModel {
  String? message;
  List<Collection>? data;

  CollectionResponseModel({this.message, this.data});

  CollectionResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Collection>[];
      json['data'].forEach((v) {
        data!.add(Collection.fromJson(v));
      });
    }
  }
}

class Collection {
  int? id;
  String? name;
  String? image;
  String? deviceId;
  String? createdAt;
  String? updatedAt;
  int? affirmationsCount;
  String? totalAffirmationsDuration;
  List<CollectionAffirmations>? affirmations;

  Collection({
    this.id,
    this.name,
    this.image,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
    this.affirmationsCount,
    this.totalAffirmationsDuration,
    this.affirmations,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    deviceId = json['device_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affirmationsCount = json['affirmations_count'];
    totalAffirmationsDuration = json['total_affirmations_duration'];

    affirmations = json['affirmations'] != null
        ? (json['affirmations'] as List)
            .map((e) => CollectionAffirmations.fromJson(e))
            .toList()
        : <CollectionAffirmations>[];
  }

  String get totalAffirmationsDurationString =>
      formatDurationString(totalAffirmationsDuration ?? "00:00:00");
}

class CollectionAffirmations {
  int? id;
  int? userId;
  int? categoryId;
  int? subCategoryId;
  String? subscriptionPlan;
  String? title;
  String? description;
  String? image;
  String? subForm;
  String? tags;
  String? language;
  int? status;
  String? adamVoiceUrl;
  String? aliceVoiceUrl;
  String? antoniVoiceUrl;
  String? arnoldVoiceUrl;
  String? audioPath;
  int? favorite;
  String? createdAt;
  String? updatedAt;
  CollectionPivot? pivot;
  String? itemIndex;
  String? affirmationDuration;

  CollectionAffirmations(
      {this.id,
      this.userId,
      this.categoryId,
      this.subCategoryId,
      this.subscriptionPlan,
      this.title,
      this.description,
      this.image,
      this.subForm,
      this.tags,
      this.language,
      this.status,
      this.adamVoiceUrl,
      this.aliceVoiceUrl,
      this.antoniVoiceUrl,
      this.arnoldVoiceUrl,
      this.audioPath,
      this.favorite,
      this.createdAt,
      this.updatedAt,
      this.pivot,
      this.itemIndex,
      this.affirmationDuration});

  CollectionAffirmations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    subscriptionPlan = json['subscription_plan'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    subForm = json['sub_form'];
    tags = json['tags'];
    language = json['language'];
    status = json['status'];
    adamVoiceUrl = json['adam_voice_url'];
    //adamVoiceUrl = "https://cdn.pixabay.com/audio/2025/01/11/audio_c352921d51.mp3";
    aliceVoiceUrl = json['alice_voice_url'];
    antoniVoiceUrl = json['antoni_voice_url'];
    arnoldVoiceUrl = json['arnold_voice_url'];
    audioPath = json['audio_path'];
    favorite = json['favorite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot =
        json['pivot'] != null ? CollectionPivot.fromJson(json['pivot']) : null;
    itemIndex = json['item_index'];
    affirmationDuration = json['affirmation_duration'];
  }
}

class CollectionPivot {
  int? collectionId;
  int? affirmationId;

  CollectionPivot({this.collectionId, this.affirmationId});

  CollectionPivot.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    affirmationId = json['affirmation_id'];
  }
}
