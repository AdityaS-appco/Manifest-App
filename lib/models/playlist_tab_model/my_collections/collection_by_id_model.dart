class CollectionByIDModel {
  String? message;
  Data? data;

  CollectionByIDModel({this.message, this.data});

  CollectionByIDModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? id;
  String? name;
  String? image;
  String? deviceId;
  String? createdAt;
  String? updatedAt;
  int? affirmationsCount;
  String? totalAffirmationsDuration;
  List<Affirmations>? affirmations;

  Data(
      {this.id,
        this.name,
        this.image,
        this.deviceId,
        this.createdAt,
        this.updatedAt,
        this.affirmationsCount,
        this.totalAffirmationsDuration,
        this.affirmations});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    affirmationsCount = json['affirmations_count'];
    totalAffirmationsDuration = json['total_affirmations_duration'];
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
  int? categoryId;
  int? subCategoryId;
  String? title;
  String? description;
  String? image;
  String? subForm;
  String? tags;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  String? itemIndex;
  String? affirmationDuration;

  Affirmations(
      {this.id,
        this.userId,
        this.categoryId,
        this.subCategoryId,
        this.title,
        this.description,
        this.image,
        this.subForm,
        this.tags,
        this.createdAt,
        this.updatedAt,
        this.pivot,
        this.itemIndex,
        this.affirmationDuration});

  Affirmations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    subForm = json['sub_form'];
    tags = json['tags'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    itemIndex = json['item_index'];
    affirmationDuration = json['affirmation_duration'];
  }
}

class Pivot {
  int? collectionId;
  int? affirmationId;

  Pivot({this.collectionId, this.affirmationId});

  Pivot.fromJson(Map<String, dynamic> json) {
    collectionId = json['collection_id'];
    affirmationId = json['affirmation_id'];
  }
}
