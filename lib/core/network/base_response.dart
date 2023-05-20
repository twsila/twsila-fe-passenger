class BaseResponse {
  bool? success;
  String? errorMessage;
  String? errorCode;
  String? dateTime;
  int? status;
  dynamic result;

  BaseResponse({
    this.errorMessage,
    this.success,
    this.errorCode,
    this.dateTime,
    this.status,
  });

  BaseResponse.fromJson(Map<String, dynamic> json, {int? statusCode}) {
    errorMessage = json['message'];
    errorCode = json['errorCode'];
    success = json['success'];
    dateTime = json['dateTime'];
    result = json['result'];
    status = statusCode;
  }
}
