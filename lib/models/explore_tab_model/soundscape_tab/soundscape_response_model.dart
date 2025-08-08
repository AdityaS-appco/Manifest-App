import 'package:manifest/features/explore/models/image_with_metadata.dart';
import 'package:manifest/features/playlist/playlist_type.enum.dart';

class SoundscapeResponseModel {
  String? message;
  List<String>? tagList;
  List<Soundscape>? data;
  Pagination? pagination;

  SoundscapeResponseModel({
    this.message,
    this.tagList,
    this.data,
    this.pagination,
  });

  factory SoundscapeResponseModel.fromJson(Map<String, dynamic> json) {
    return SoundscapeResponseModel(
      message: json['message'],
      tagList: List<String>.from(json['tag_list']),
      data: List<Soundscape>.from(
        json['data'].map((x) => Soundscape.fromJson(x)),
      ),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Soundscape {
  int? id;
  String? name;
  ImageData? artCover;
  String? category;
  String? videoTheme;
  String? tags;
  String? description;
  String? sound;
  int? status;
  int? favorite;
  int? userId;
  String? deviceId;
  PlaylistType? createdBy;
  String? file;
  String? subscriptionPlan;
  DateTime? createdAt;
  DateTime? updatedAt;

  Soundscape({
    this.id,
    this.name,
    this.artCover,
    this.category,
    this.videoTheme,
    this.tags,
    this.description,
    this.sound,
    this.status,
    this.favorite,
    this.userId,
    this.deviceId,
    this.createdBy,
    this.file,
    this.subscriptionPlan,
    this.createdAt,
    this.updatedAt,
  });

  bool get isPaid => subscriptionPlan == '1' || subscriptionPlan == 'paid' || subscriptionPlan == null;

  factory Soundscape.fromJson(Map<String, dynamic> json) {
    return Soundscape(
      id: json['id'] is String ? int.tryParse(json['id']) : json['id'],
      name: json['name'],
      artCover: ImageData.fromJson(json['art_cover']),
      category: json['category'],
      videoTheme: json['video_theme'],
      tags: json['tags'],
      description: json['description'],
      sound: json['sound'],
      status: json['status'] is String
          ? int.tryParse(json['status'])
          : json['status'],
      favorite: json['favorite'] is String
          ? int.tryParse(json['favorite'])
          : json['favorite'],
      userId: json['user_id'] is String
          ? int.tryParse(json['user_id'])
          : json['user_id'],
      deviceId: json['device_id'],
      createdBy: (json['created_by'] as String? ?? 'A') == 'A' || (json['created_by'] as String? ?? 'A') == '1'
          ? PlaylistType.admin
          : PlaylistType.custom,
      file: json['file'],
      subscriptionPlan: json['subscription_plan'].toString(),
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'art_cover': artCover?.toJson(),
      'category': category,
      'video_theme': videoTheme,
      'tags': tags,
      'description': description,
      'sound': sound,
      'status': status, 
     'favorite': favorite,
     'user_id': userId,
     'device_id': deviceId,
     'created_by': createdBy?.name,
     'file': file,
     'subscription_plan': subscriptionPlan,
     'created_at': createdAt?.toIso8601String(),
     'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class Pagination {
  int currentPage;
  int perPage;
  int total;
  int lastPage;

  Pagination({
    this.currentPage = 1,
    this.perPage = 9,
    this.total = 0,
    this.lastPage = 1,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'] is String
          ? int.tryParse(json['current_page']) ?? 1
          : json['current_page'] ?? 1,
      perPage: json['per_page'] is String
          ? int.tryParse(json['per_page']) ?? 10
          : json['per_page'] ?? 10,
      total: json['total'] is String
          ? int.tryParse(json['total']) ?? 0
          : json['total'] ?? 0,
      lastPage: json['last_page'] is String
          ? int.tryParse(json['last_page']) ?? 1
          : json['last_page'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
      'last_page': lastPage,
    };
  }
}
