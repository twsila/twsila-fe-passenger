import '../../data/model/request-model.dart';

abstract class BaseRequestInterface {
  Future<dynamic> sendRequest(RequestModel requestModel, [String param = '']);

  Future<dynamic> sendMultiPartRequest(
    RequestModel requestModel,
    String filePath,
    Map<String, String> fields,
  );
}
