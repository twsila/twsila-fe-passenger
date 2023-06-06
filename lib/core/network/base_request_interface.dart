import 'package:image_picker/image_picker.dart';

import '../../data/model/request-model.dart';

abstract class BaseRequestInterface {
  Future<dynamic> sendRequest(RequestModel requestModel, [String param = '']);

  Future<dynamic> sendMultiPartRequest(
    RequestModel requestModel,
    List<XFile>? files,
    Map<String, dynamic> fields,
  );
}
