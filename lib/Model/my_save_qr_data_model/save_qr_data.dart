import 'package:collection/collection.dart';

class SaveQrData {
  int? id;
  String? title;
  String? qrCode;

  SaveQrData({this.id, this.title, this.qrCode});

  factory SaveQrData.fromJson(Map<String, dynamic> json) => SaveQrData(
        id: json['id'] as int?,
        title: json['title'] as String?,
        qrCode: json['qr_code'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'qr_code': qrCode,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SaveQrData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ qrCode.hashCode;
}
