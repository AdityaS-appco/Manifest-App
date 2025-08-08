import 'package:manifest/core/utils/helpers.dart';
import 'package:manifest/features/explore/models/image_with_metadata.dart';

class HomeDataModelByAlok {
  String? message;
  List<HomeData>? data;

  HomeDataModelByAlok({
    this.message,
    this.data,
  });

  HomeDataModelByAlok copyWith({
    String? message,
    List<HomeData>? data,
  }) =>
      HomeDataModelByAlok(
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory HomeDataModelByAlok.fromJson(Map<String, dynamic> json) =>
      HomeDataModelByAlok(
        message: json["message"],
        data: List<HomeData>.from(
          (json["data"] as List)
              .whereType<Map<String, dynamic>>()
              .map((x) => HomeData.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class HomeData {
  String? title;
  String? subtitle;
  final List<Content> content;
  String? tags;
  String? key;

  /// * Returns list of trimmed tags from comma separated string
  List<String> get tagList =>
      tags?.split(',').map((e) => e.trim()).toList() ?? [];

  HomeData({
    this.title,
    this.subtitle,
    required this.content,
    this.tags,
    this.key,
  });

  HomeData copyWith({
    String? title,
    String? subtitle,
    required List<Content> content,
    String? tags,
    String? key,
  }) =>
      HomeData(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        content: content ?? this.content,
        tags: tags ?? this.tags,
        key: key ?? this.key,
      );

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        /// todo: replace name with title when changed in the api
        title: json["title"],
        subtitle: json["subtitle"],
        tags: json["tags"],
        content: json["content"] != null
            ? List<Content>.from(
                (json["content"] as List).map((x) => Content.fromJson(x)))
            : <Content>[],
        key: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "tags": tags,
        "content": content?.map((x) => x.toJson()).toList(),
        "key": key,
      };
}

class Content {
  String? type;
  String? name;
  int? id;
  ImageData? image;
  String? isPaid;
  int? durationInSeconds;
  String? authorName;

  Content({
    this.type,
    this.id,
    this.image,
    this.isPaid,
    this.name,
    this.durationInSeconds,
    this.authorName,
  });

  Content copyWith({
    String? type,
    int? id,
    ImageData? image,
    String? isPaid,
    String? name,
    int? durationInSeconds,
    String? authorName,
  }) =>
      Content(
        type: type ?? this.type,
        id: id ?? this.id,
        image: image ?? this.image,
        isPaid: isPaid ?? this.isPaid,
        name: name ?? this.name,
        durationInSeconds: durationInSeconds ?? this.durationInSeconds,
        authorName: authorName ?? this.authorName,
      );

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      type: json["type"],
      id: json["id"],
      image: parseImageData(json['image']),
      isPaid: json["is_paid"]?.toString(),
      name: json["name"] ?? "Unknown",
      durationInSeconds: json["duration_in_seconds"],
      authorName: json["author_name"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "image": image,
        "is_paid": isPaid,
        "name": name,
        "duration_in_seconds": durationInSeconds,
        "author_name": authorName,
      };

  String get durationInSecondsString =>
      formatSecondsToDurationString(durationInSeconds);

  bool get isPremium =>
      isPaid?.toLowerCase() == '1' || isPaid?.toLowerCase() == 'paid';

  bool get isPlaylist => type?.toLowerCase() == 'playlist';

  bool get isCollection => type?.toLowerCase() == 'collection';

  bool get isTrack => type?.toLowerCase() == 'track';
}
