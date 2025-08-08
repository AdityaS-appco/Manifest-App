// class HomeModel {
//   String? message;
//   List<Data>? data;
//
//   HomeModel({this.message, this.data});
//
//   HomeModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   String? name;
//   String? image;
//   List<PlayList>? playList;
//
//   Data({this.id, this.name, this.image, this.playList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     if (json['play_list'] != null) {
//       playList = <PlayList>[];
//       json['play_list'].forEach((v) {
//         playList!.add(new PlayList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     if (this.playList != null) {
//       data['play_list'] = this.playList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class PlayList {
//   int? id;
//   String? name;
//   String? image;
//   String? type;
//   bool? featured;
//   int? totalAffirmation;
//   String? playlistTimeDuration;
//   List<String>? tags;
//   List<Affirmations>? affirmations;
//
//   PlayList(
//       {this.id,
//         this.name,
//         this.image,
//         this.type,
//         this.featured,
//         this.totalAffirmation,
//         this.playlistTimeDuration,
//         this.tags,
//         this.affirmations});
//
//   PlayList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     type = json['type'];
//     featured = json['featured'];
//     totalAffirmation = json['total_affirmation'];
//     playlistTimeDuration = json['playlist_time_duration'];
//     tags = json['tags'].cast<String>();
//     if (json['affirmations'] != null) {
//       affirmations = <Affirmations>[];
//       json['affirmations'].forEach((v) {
//         affirmations!.add(new Affirmations.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['type'] = this.type;
//     data['featured'] = this.featured;
//     data['total_affirmation'] = this.totalAffirmation;
//     data['playlist_time_duration'] = this.playlistTimeDuration;
//     data['tags'] = this.tags;
//     if (this.affirmations != null) {
//       data['affirmations'] = this.affirmations!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Affirmations {
//   int? id;
//   int? categoryId;
//   String? categoryName;
//   int? subCategoryId;
//   String? subCategoryName;
//   String? title;
//   String? description;
//   String? affirmationImage;
//   String? tags;
//   bool? isFavorite;
//   String? audio;
//   String? image;
//   String? audioDuration;
//   List<TypesOfVoices>? typesOfVoices;
//
//   Affirmations(
//       {this.id,
//         this.categoryId,
//         this.categoryName,
//         this.subCategoryId,
//         this.subCategoryName,
//         this.title,
//         this.description,
//         this.affirmationImage,
//         this.tags,
//         this.isFavorite,
//         this.audio,
//         this.image,
//         this.audioDuration,
//         this.typesOfVoices});
//
//   Affirmations.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     categoryId = json['category_id'];
//     categoryName = json['category_name'];
//     subCategoryId = json['sub_category_id'];
//     subCategoryName = json['sub_category_name'];
//     title = json['title'];
//     description = json['description'];
//     affirmationImage = json['affirmationImage'];
//     tags = json['tags'];
//     isFavorite = json['is_favorite'];
//     audio = json['audio'];
//     image = json['image'];
//     audioDuration = json['audio_duration'];
//     if (json['types_of_voices'] != null) {
//       typesOfVoices = <TypesOfVoices>[];
//       json['types_of_voices'].forEach((v) {
//         typesOfVoices!.add(new TypesOfVoices.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category_id'] = this.categoryId;
//     data['category_name'] = this.categoryName;
//     data['sub_category_id'] = this.subCategoryId;
//     data['sub_category_name'] = this.subCategoryName;
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['affirmationImage'] = this.affirmationImage;
//     data['tags'] = this.tags;
//     data['is_favorite'] = this.isFavorite;
//     data['audio'] = this.audio;
//     data['image'] = this.image;
//     data['audio_duration'] = this.audioDuration;
//     if (this.typesOfVoices != null) {
//       data['types_of_voices'] =
//           this.typesOfVoices!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class TypesOfVoices {
//   int? id;
//   String? name;
//   String? image;
//   String? music;
//
//   TypesOfVoices({this.id, this.name, this.image, this.music});
//
//   TypesOfVoices.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     music = json['music'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['music'] = this.music;
//     return data;
//   }
// }

class HomeModel {
  String? message;
  List<Data>? data;

  HomeModel({this.message, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
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
  String? name;
  String? image;
  List<PlayList>? playList;

  Data({this.id, this.name, this.image, this.playList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['play_list'] != null) {
      playList = <PlayList>[];
      json['play_list'].forEach((v) {
        playList!.add(PlayList.fromJson(v));
      });
    }
  }
}

class PlayList {
  int? id;
  String? name;
  String? image;
  String? type;
  bool? featured;
  int? totalAffirmation;
  String? playlistTimeDuration;
  List<String>? tags;
  List<Affirmations>? affirmations;

  PlayList(
      {this.id,
        this.name,
        this.image,
        this.type,
        this.featured,
        this.totalAffirmation,
        this.playlistTimeDuration,
        this.tags,
        this.affirmations});

  PlayList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    type = json['type'];
    featured = json['featured'];
    totalAffirmation = json['total_affirmation'];
    playlistTimeDuration = json['playlist_time_duration'];
    tags = json['tags'].cast<String>();
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

  Affirmations(
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

  Affirmations.fromJson(Map<String, dynamic> json) {
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
