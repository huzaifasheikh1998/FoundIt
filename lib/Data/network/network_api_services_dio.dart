import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:foundit/Data/appException/app_exception.dart';
import 'package:foundit/Data/network/base_api_services_dio.dart';
import 'package:foundit/resources/app_url/app_url.dart';
import 'package:image_picker/image_picker.dart';

class NetworkApiServices implements BaseApiServices {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppUrl.baseUrl,
      connectTimeout: Duration(seconds: 20),
      // headers: {
      //   'Content-Type': 'application/json',
      // }
    ),
  );

  static final NetworkApiServices ins = NetworkApiServices._();

  NetworkApiServices._() {
    updateDio();
  }

  @override // optional to use , Dart will throw a compile-time error if super class doesnt contains this method
  Future<Map<String, dynamic>> post(String endPoint, Map<String, dynamic> data,
      {Map<String, dynamic> queryParameters = const {},
      String? baseUrl,
      bool formData = false}) async {
    Response? response;
    try {
      dio.options.baseUrl = baseUrl ?? AppUrl.baseUrl;
      response = await dio.post(endPoint,
          data: formData ? FormData.fromMap(data) : jsonEncode(data),
          options: getAccessToken(),
          queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleException(e);
    } on SocketException catch (_) {
      throw InternetException('No Internet Connection.');
    }
    // catch (e) {
    //  // log(e.toString());
    // }
    log(response!.data.toString());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>?> update(
      String endPoint, Map<String, dynamic> data,
      {Map<String, dynamic> queryParameters = const {},
      String? baseUrl}) async {
    Response? response;
    try {
      dio.options.baseUrl = baseUrl ?? AppUrl.baseUrl;

      response = await dio.put(endPoint,
          data: jsonEncode(data),
          options: getAccessToken(),
          queryParameters: queryParameters);
    } on DioException catch (e) {
      _handleException(e);
    } on SocketException catch (_) {
      throw InternetException('No Internet Connection.');
    }
    return response?.data;
  }

  @override
  Future<Map<String, dynamic>> postFile(
      String endPoint, Map<String, dynamic> data,
      {Map<String, dynamic> queryParameters = const {},
      String? baseUrl}) async {
    Response? response;
    try {
      dio.options.baseUrl = baseUrl ?? AppUrl.baseUrl;

      response = await dio.post(
        endPoint,
        data: FormData.fromMap(data),
        options: Options(
          method: 'POST',
          contentType: 'multipart',
        ),
      );
    } on DioException catch (e) {
      _handleException(e);
    } on SocketException catch (_) {
      throw InternetException('No Internet Connection.');
    }
    return response?.data;
  }

  Future<Map<String, dynamic>> postMultipleFiles(
      String endPoint, Map<String, dynamic> data,
      {List<XFile> files = const [],
      Map<String, dynamic> queryParameters = const {},
      String? baseUrl}) async {
    Response? response;
    try {
      dio.options.baseUrl = baseUrl ?? AppUrl.baseUrl;

      FormData formData = FormData();

      // Add files to FormData
      for (int i = 0; i < files.length; i++) {
        formData.files.add(
          MapEntry(
            'attachement[]',
            await MultipartFile.fromFile(files[i].path),
          ),
        );
      }

      // Add additional data
      data.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      response = await dio.post(
        endPoint,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          method: 'POST',
          contentType: 'multipart/form-data', // Change to 'multipart/form-data'
        ),
      );
    } on DioException catch (e) {
      // Handle Dio errors
      print('Dio Error: $e');
      throw e; // Rethrow the error for handling elsewhere
    } on SocketException catch (_) {
      // Handle socket errors
      throw InternetException('No Internet Connection.');
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
      throw e;
    }
    return response.data;
  }

  @override
  Future<Map<String, dynamic>?> get(String endPoint,
      {Map<String, dynamic> queryParameters = const {},
      String? baseUrl}) async {
    Response? response;
    try {
      dio.options.baseUrl = baseUrl ?? AppUrl.baseUrl;
      response = await dio.get(
        endPoint,
        options: getAccessToken(),
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      _handleException(e);
    } on SocketException catch (_) {
      throw InternetException('No Internet Connection.');
    }
    return response?.data;
  }

  Options getAccessToken() {
    return Options(responseType: ResponseType.json);
  }

  @override
  void updateDio() {
    dio.options.headers = <String, dynamic>{
      'authorization': '',
      'deviceToken': '',
      'Content-Type': 'application/json'
    };
  }

  void updateAuthDio(String authToken) {
    dio.options.headers = <String, dynamic>{
      'Authorization': 'Bearer $authToken',
      'Content-Type': 'application/json'
    };
    print(
        "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<${dio.options.headers}>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
  }

  void _handleException(DioException e) {
    if (e.type == DioExceptionType.badResponse) {
      String? msg;
      if (e.response?.data is Map) {
        msg = e.response?.data["message"].toString();
      } else {
        msg = e.message.toString();
      }
      // log(msg.toString(), name: "Api Response Error");

// e.response?.data['raw']['message'] ??
      //  msg =
      // e.response?.data["message"] as String? ?? e.message.toString();

      switch (e.response?.statusCode) {
        case 400:
          throw ApiException(msg);
        case 401:
          throw ApiException(msg);
        case 404:
          throw ApiException(msg);
        case 500:
          throw BadRequestException(msg);
        default:
          throw FetchDataException("Oops! Something went wrong.");
      }
    } else if (e.type == DioExceptionType.connectionError) {
      throw InternetException('');
    } else if (e.type == DioExceptionType.connectionTimeout) {
      throw RequestTimeOut('');
    }
  }
}
