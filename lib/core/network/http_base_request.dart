import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/app/app_prefs.dart';
import 'package:taxi_for_you/app/constants.dart';
import 'package:taxi_for_you/core/network/base_request_interface.dart';
import 'package:taxi_for_you/data/model/request-model.dart';
import 'package:taxi_for_you/data/model/user-model.dart';

import '../../app/di.dart';
import 'app_exceptions.dart';
import 'base_response.dart';

// ignore: camel_case_types, constant_identifier_names
enum NETWORK_REQUEST_TYPE { GET, POST, PUT, DELETE }

class HttpBaseRequest extends BaseRequestInterface {
  final AppPreferences appPreferences = instance<AppPreferences>();

  final JsonDecoder _decoder = const JsonDecoder();

  @override
  Future<dynamic> sendRequest(RequestModel requestModel,
      [String param = '']) async {
    http.Response response;

    Uri uri = Uri.parse(Constants.baseUrl + requestModel.endPoint);

    var headers = checkHeaders();

    var requestEncoded = json.encode(requestModel.reqBody);
    printFunction(requestModel, headers);

    try {
      if (requestModel.requestType == NETWORK_REQUEST_TYPE.POST) {
        response = await http
            .post(uri, body: requestEncoded, headers: headers)
            .timeout(
              const Duration(seconds: Constants.apiTimeOut),
            );
      } else {
        response = await http
            .get(uri, headers: headers)
            .timeout(const Duration(seconds: Constants.apiTimeOut));
      }
      return _returnResponse(response);
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw AppTimeOutException();
    } on FormatException catch (e) {
      throw InvalidInputException();
    } catch (e) {
      if (e is PlatformException) {
        throw PlatformException(
          message: e.message,
          code: e.code,
          details: e.details,
        );
      }
      throw FetchDataException();
    }
  }

  @override
  Future<dynamic> sendMultiPartRequest(
    RequestModel requestModel,
    List<XFile>? files,
    Map<String, dynamic> fields,
  ) async {
    Uri uri = Uri.parse(Constants.baseUrl + requestModel.endPoint);
    var request =
        http.MultipartRequest(NETWORK_REQUEST_TYPE.POST.toString(), uri);

    var headers = checkHeaders(isMultiPart: true);

    request.headers.addAll(headers);
    print('Headers: ${request.headers}');
    fields.forEach((key, value) {
      request.fields[key] = value;
      print(value);
    });

    if (files != null && files.isNotEmpty) {
      files.forEach((element) async {
        var multipartFile = await http.MultipartFile.fromPath(
          "tripImages",
          element.path,
        );
        request.files.add(multipartFile);
      });
    }

    print(uri);
    print("*****************Request******************");
    print(this.toString());
    log("Request Body:${request.fields}");

    log("Request Body:${request.files}");
    try {
      var streamedResponse = await request
          .send()
          .timeout(const Duration(seconds: Constants.apiTimeOut));
      var response = await http.Response.fromStream(streamedResponse);
      return response;
    } on SocketException {
      throw NoInternetException();
    } on TimeoutException {
      throw AppTimeOutException();
    } on FormatException catch (e) {
      print(e.message);
      throw InvalidInputException();
    } catch (e) {
      throw FetchDataException();
    }
  }

  dynamic _returnResponse(http.Response response) {
    late BaseResponse baseResponse;
    if (response.bodyBytes.isNotEmpty) {
      print(_decoder.convert(utf8.decode(response.bodyBytes)));
      baseResponse = BaseResponse.fromJson(
        _decoder.convert(utf8.decode(response.bodyBytes)),
        statusCode: response.statusCode,
      );
    } else {
      baseResponse = BaseResponse(
        errorMessage: response.reasonPhrase,
        status: response.statusCode,
      );
    }

    switch (response.statusCode) {
      case 200:
        return baseResponse;
      default:
        throw PlatformException(
          message: baseResponse.errorMessage ?? '',
          code: baseResponse.errorCode ?? '',
          details: baseResponse,
        );
    }
  }

  Map<String, String> checkHeaders({bool isMultiPart = false}) {
    Map<String, String> headers = {};
    UserModel? userModel = appPreferences.getUserData();

    if (userModel != null && userModel.token != null) {
      headers = {
        'Authorization': 'Bearer ${userModel.token}',
        "Accept": "*/*",
        'Accept-Language': appPreferences.getAppLanguage(),
        "Content-Type":
            isMultiPart ? "multipart/form-data" : "application/json",
      };
    } else {
      headers = {
        'Authorization': Constants.constAuth,
        "Accept": "*/*",
        'Accept-Language': appPreferences.getAppLanguage(),
        "Content-Type":
            isMultiPart ? "multipart/form-data" : "application/json",
      };
    }

    return headers;
  }

  printFunction(RequestModel requestModel, Map<String, String> headers) {
    var requestEncoded = json.encode(requestModel.reqBody);
    print("""
    uri: ${Constants.baseUrl + requestModel.endPoint}
    body: $requestEncoded
    headers: $headers
    method: ${requestModel.requestType}""");
  }
}
