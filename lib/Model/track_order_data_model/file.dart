import 'package:collection/collection.dart';

class File {
  int? id;
  String? type;
  String? hash;
  String? url;
  String? filename;
  String? mimeType;
  int? size;
  int? width;
  int? height;
  dynamic dpi;
  String? status;
  int? created;
  String? thumbnailUrl;
  String? previewUrl;
  bool? visible;
  bool? isTemporary;

  File({
    this.id,
    this.type,
    this.hash,
    this.url,
    this.filename,
    this.mimeType,
    this.size,
    this.width,
    this.height,
    this.dpi,
    this.status,
    this.created,
    this.thumbnailUrl,
    this.previewUrl,
    this.visible,
    this.isTemporary,
  });

  factory File.fromJson(Map<String, dynamic> json) => File(
        id: json['id'] as int?,
        type: json['type'] as String?,
        hash: json['hash'] as String?,
        url: json['url'] as String?,
        filename: json['filename'] as String?,
        mimeType: json['mime_type'] as String?,
        size: json['size'] as int?,
        width: json['width'] as int?,
        height: json['height'] as int?,
        dpi: json['dpi'] as dynamic,
        status: json['status'] as String?,
        created: json['created'] as int?,
        thumbnailUrl: json['thumbnail_url'] as String?,
        previewUrl: json['preview_url'] as String?,
        visible: json['visible'] as bool?,
        isTemporary: json['is_temporary'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'hash': hash,
        'url': url,
        'filename': filename,
        'mime_type': mimeType,
        'size': size,
        'width': width,
        'height': height,
        'dpi': dpi,
        'status': status,
        'created': created,
        'thumbnail_url': thumbnailUrl,
        'preview_url': previewUrl,
        'visible': visible,
        'is_temporary': isTemporary,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! File) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      hash.hashCode ^
      url.hashCode ^
      filename.hashCode ^
      mimeType.hashCode ^
      size.hashCode ^
      width.hashCode ^
      height.hashCode ^
      dpi.hashCode ^
      status.hashCode ^
      created.hashCode ^
      thumbnailUrl.hashCode ^
      previewUrl.hashCode ^
      visible.hashCode ^
      isTemporary.hashCode;
}
