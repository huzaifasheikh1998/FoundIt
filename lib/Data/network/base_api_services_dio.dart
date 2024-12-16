import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class BaseApiServices {
  Future<Map<String, dynamic>?> post(
    String endPoint,
    Map<String, dynamic> data, {
    Map<String, dynamic> queryParameters = const {},
    String? baseUrl,
  }); // abstract method => func only declared but not implemented yet

  Future<Map<String, dynamic>?> update(
      String endPoint, Map<String, dynamic> data,
      {Map<String, dynamic> queryParameters = const {}});

  Future<Map<String, dynamic>> postFile(
      String endPoint, Map<String, dynamic> data,
      {Map<String, dynamic> queryParameters = const {}});

  Future<Map<String, dynamic>> postMultipleFiles(
      String endPoint, Map<String, dynamic> data,
      {List<XFile> files = const [],
      Map<String, dynamic> queryParameters = const {},
      String? baseUrl});

  Future<Map<String, dynamic>?> get(String endPoint,
      {Map<String, dynamic> queryParameters = const {}});
  void updateDio();
}
