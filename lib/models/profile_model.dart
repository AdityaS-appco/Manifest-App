class ProfileResponseModel {
  String? message;
  Profile? data;
  ProfileResponseModel({this.message, this.data});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = Profile.fromJson(json['data']);
    } else {
      data = null;
    }
  }
}

class Profile {
  final int? id;
  final String? name;
  final String? nickName;
  final String? email;
  final String? findFrom;
  final String? image;
  final String? dateOfBirth;
  final String? gender;
  final bool? isPremium;

  Profile({
    this.id,
    this.name,
    this.nickName,
    this.email,
    this.findFrom,
    this.image,
    this.dateOfBirth,
    this.gender,
    this.isPremium,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'] ?? 'Guest',
      nickName: json['nickname'],
      email: json['email'],
      findFrom: json['find_from'],
      image: json['image'],
      dateOfBirth: json['dob'] ?? "Not Set",
      gender: json['gender'] ?? "Not Set",
      isPremium: json['is_premium'] ?? true,
    );
  }
}
