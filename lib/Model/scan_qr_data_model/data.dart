import 'package:collection/collection.dart';
import 'package:foundit/Model/get_boxes_model.dart';

class Data {
  int? id;
  String? boxName;
  dynamic boxWeight;
  String? thumbnail;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? userId;
  dynamic height;
  dynamic width;
  dynamic deletedAt;
  String? userDate;

  Data({
    this.id,
    this.boxName,
    this.boxWeight,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.height,
    this.width,
    this.deletedAt,
    this.userDate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        boxName: json['box_name'] as String?,
        boxWeight: json['box_weight'] as dynamic,
        thumbnail: json['thumbnail'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        userId: json['user_id'] as int?,
        height: json['height'] as dynamic,
        width: json['width'] as dynamic,
        deletedAt: json['deleted_at'] as dynamic,
        userDate: json['user_date'] as String?,
      );

  Box toDomain() => Box(id: id, boxName: boxName, thumbnail: thumbnail);

  Map<String, dynamic> toJson() => {
        'id': id,
        'box_name': boxName,
        'box_weight': boxWeight,
        'thumbnail': thumbnail,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_id': userId,
        'height': height,
        'width': width,
        'deleted_at': deletedAt,
        'user_date': userDate,
      };
}
