import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as _get;
import 'package:http_parser/http_parser.dart' as httpParser;
import 'package:path/path.dart' as path;

import '../resources/components/Global.dart';

class HttpHelper {
  String baseUrl = "https://foundit.thesuitchstaging.com/api/v9/";
  final Dio dio = Dio();

  static final HttpHelper ins = HttpHelper._();

  HttpHelper._() {
    initializeDio();
  }

  Future<Map<String, dynamic>> post(
      String endPoint, Map<String, dynamic> data, BuildContext context,
      {Map<String, dynamic> queryParameters = const {}}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    Response? response;
    try {
      response = await dio.post(endPoint,
          data: FormData.fromMap(data),
          options: getAccessToken(),
          queryParameters: queryParameters);
    } on DioException catch (e) {
      response = e.response;
    } catch (e) {
      _get.Get.snackbar("Error", e.toString());
    }
    Navigator.pop(context);
    Map<String, dynamic> map = response?.data as Map<String, dynamic>? ?? {};
    return map;
  }

  Future<Map<String, dynamic>> update(
      String endPoint, Map<String, dynamic> data, BuildContext context,
      {Map<String, dynamic> queryParameters = const {}}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    Response? response;
    try {
      response = await dio.put(endPoint,
          data: jsonEncode(data),
          options: getAccessToken(),
          queryParameters: queryParameters);
    } on DioException catch (e) {
      response = e.response;
    } catch (e) {
      _get.Get.snackbar("Error", e.toString());
    }
    Navigator.pop(context);
    Map<String, dynamic> map = response?.data as Map<String, dynamic>? ?? {};
    return map;
  }

  Future<Map<String, dynamic>> delete(String endPoint, BuildContext context,
      {Map<String, dynamic> queryParameters = const {}}) async {
    Response? response;
    try {
      response = await dio.delete(endPoint,
          options: getAccessToken(), queryParameters: queryParameters);
    } on DioException catch (e) {
      response = e.response;
    } catch (e) {
      _get.Get.snackbar("Error", e.toString());
    }
    // Navigator.pop(context);
    Map<String, dynamic> map = response?.data as Map<String, dynamic>? ?? {};
    return map;
  }

  Future<Map<String, dynamic>> postWithFile({
    required String endPoint,
    required Map<String, dynamic> data,
    required BuildContext context,
    File? file,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );
    Response? response;
    try {
      if (file != null) {
        data['image'] = await MultipartFile.fromFile(
          file.path,
          filename: path.basename(file.path),
          contentType: httpParser.MediaType.parse('image/jpeg'),
        );
      }
      response = await dio.post(
        endPoint,
        data: FormData.fromMap(data),
        options: Options(
          method: 'POST',
          contentType: 'multipart;',
        ),
      );
    } on DioException catch (e) {
      response = e.response;
    } catch (e) {
      _get.Get.snackbar("Error", e.toString());
    }
    Navigator.pop(context);
    Map<String, dynamic> map = response?.data as Map<String, dynamic>? ?? {};
    return map;
  }

  Future<Map<String, dynamic>> get(String endPoint, BuildContext context,
      {Map<String, dynamic> queryParameters = const {}}) async {
    Response? response;
    try {
      response = await dio.get(
        endPoint,
        options: getAccessToken(),
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      response = e.response;
    } catch (e) {
      _get.Get.snackbar('Error', e.toString());
    }
    Map<String, dynamic> map = response?.data as Map<String, dynamic>? ?? {};
    return map;
  }

  Options getAccessToken() {
    return Options(responseType: ResponseType.json);
  }

  void initializeDio() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = <String, dynamic>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AuthToken}',
    };
  }
}
