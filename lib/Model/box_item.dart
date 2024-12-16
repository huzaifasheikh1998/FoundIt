import 'package:get/get.dart';

class BoxItem {
  BoxItem({
    required this.id,
    required this.itemName,
    required this.categoriesName,
    required this.thumbnail,
  });
  late final int id;
  late final String itemName;
  late final String categoriesName;
  late final String thumbnail;

  BoxItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    categoriesName = json['categories_name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['item_name'] = itemName;
    _data['categories_name'] = categoriesName;
    _data['thumbnail'] = thumbnail;
    return _data;
  }
}

RxList<dynamic> items = [].obs;
