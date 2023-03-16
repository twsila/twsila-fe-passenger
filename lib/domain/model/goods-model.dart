import 'package:image_picker/image_picker.dart';

import '../../presentation/google_maps/model/location_model.dart';

class GoodsModel {
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  String? transportationNature;
  String? kindOfWrapping;
  int? paymentValue;
  int? goodsWeight;
  bool loadingBool = false;
  bool wrappingBool = false;
  bool craneBool = false;
  List<XFile>? images;
}
