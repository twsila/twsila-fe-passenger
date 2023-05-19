import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:taxi_for_you/app/constants.dart';

import 'app_exceptions.dart';
import 'base_response.dart';

// ignore: camel_case_types, constant_identifier_names
enum NETWORK_REQUEST_TYPE { GET, POST, PUT, DELETE }

class BaseRequest {
  NETWORK_REQUEST_TYPE requestType;
  String endPoint;
  Map<String, String>? headers;

  BaseRequest({
    required this.endPoint,
    required this.requestType,
    this.headers = Constants.headers,
  });

  @override
  String toString() {
    return 'URL: ${Constants.baseUrl + endPoint}\n'
        'Headers: $headers\n'
        'Request Type: ${requestType == NETWORK_REQUEST_TYPE.GET ? "GET" : "POST"}\n';
  }

  final JsonDecoder _decoder = const JsonDecoder();

  Future<dynamic> sendRequest(Map<String, dynamic> reqBody,
      [String param = '']) async {
    var response;

    Uri uri = Uri.parse(Constants.baseUrl + endPoint);

    var requestEncoded = json.encode(reqBody);

    try {
      if (requestType == NETWORK_REQUEST_TYPE.POST) {
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
      throw FetchDataException();
    }
  }

  Future<dynamic> sendMultiPartRequest(
    String filePath,
    Map<String, String> fields,
  ) async {
    Uri uri = Uri.http(Constants.baseUrl, endPoint);
    var request =
        http.MultipartRequest(NETWORK_REQUEST_TYPE.POST.toString(), uri);
    var headers = Constants.multiPartHeaders;
    request.headers.addAll(headers);
    fields.forEach((key, value) {
      request.fields[key] = value;
      print(value);
    });
    var multipartFile = await http.MultipartFile.fromPath("file", filePath);
    request.files.add(multipartFile);
    print(uri);
    print("*****************Request******************");
    print(this.toString());
    log("Request Body:${request.fields}");

    log("Request Body:${request.files}");
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return _returnResponse(response);
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
    BaseResponse baseResponse = BaseResponse.fromJson(
      _decoder.convert(utf8.decode(response.bodyBytes)),
      status: response.statusCode,
    );
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
}
