class GoalsResponseModel {
  bool? status;
  String? message;
  List<Goal>? data;

  GoalsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory GoalsResponseModel.fromJson(Map<String, dynamic> json) =>
      GoalsResponseModel(
        status: json["status"] as bool?,
        message: json["message"] as String?,
        data: (json["data"] as List?)
            ?.map((dynamic x) => Goal.fromJson(x as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.map((x) => x.toJson()).toList(),
      };
}

class Goal {
  int? id;
  String? name;
  String? emoji;
  bool isSelected;

  Goal({
    this.id,
    this.name,
    this.emoji,
    this.isSelected = false,
  });

  factory Goal.fromJson(Map<String, dynamic> json) => Goal(
        id: json["id"] as int?,
        name: json["name"] as String?,
        emoji: json["icon"] as String?,
        isSelected: json["is_selected"].toString() == '1' ||
            json["is_selected"].toString() == 'true',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": emoji,
        "is_selected": isSelected,
      };
}
