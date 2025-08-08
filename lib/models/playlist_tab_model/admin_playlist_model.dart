import 'package:manifest/models/explore_tab_model/explore_tab/explore_categories_by_id_model.dart';

class AdminPlaylistModel {
  String? message;
  List<Playlist>? data;

  AdminPlaylistModel({this.message, this.data});

  AdminPlaylistModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Playlist>[];
      json['data'].forEach((v) {
        data!.add(Playlist.fromJson(v));
      });
    }
  }
}

// class Data {
//   int? id;
//   String? name;
//   String? image;
//   String? createdBy;
//   String? createdAt;
//   String? updatedAt;
//   int? tracksCount;

//   Data(
//       {this.id,
//         this.name,
//         this.image,
//         this.createdBy,
//         this.createdAt,
//         this.updatedAt,
//         this.tracksCount,
//        });

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     image = json['image'];
//     createdBy = json['created_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     tracksCount = json['tracks_count'];
//   }
// }
