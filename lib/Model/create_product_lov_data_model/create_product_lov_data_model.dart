import 'package:collection/collection.dart';

import 'state_list.dart';
import 'variant.dart';

class CreateProductLovDataModel {
  List<Variant>? variants;
  List<StateList>? stateList;

  CreateProductLovDataModel({this.variants, this.stateList});

  factory CreateProductLovDataModel.fromJson(Map<String, dynamic> json) {
    return CreateProductLovDataModel(
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) => Variant.fromJson(e as Map<String, dynamic>))
          .toList(),
      stateList: (json['state_list'] as List<dynamic>?)
          ?.map((e) => StateList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'variants': variants?.map((e) => e.toJson()).toList(),
        'state_list': stateList?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CreateProductLovDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => variants.hashCode ^ stateList.hashCode;
}
