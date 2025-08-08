class SurveyResponseModel {
  final String? message;
  final bool? status;
  final List<SurveyItem>? data;

  SurveyResponseModel({
    this.message,
    this.status,
    this.data,
  });

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) {
    return SurveyResponseModel(
      message: json['message'],
      status: json['status'],
      data: json['data'] != null
          ? List<SurveyItem>.from(
              json['data'].map((x) => SurveyItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class SurveyItem {
  final int? id;
  final String? name;
  final String? image;

  SurveyItem({
    this.id,
    this.name,
    this.image,
  });

  factory SurveyItem.fromJson(Map<String, dynamic> json) {
    return SurveyItem(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}