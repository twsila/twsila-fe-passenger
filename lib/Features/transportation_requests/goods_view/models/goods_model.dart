import 'package:image_picker/image_picker.dart';

class GoodsModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  String? packagingType;
  String? materialType;
  int? payloadWeight;
  int? paymentValue;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;
  List<XFile>? images;

  GoodsModel();

  GoodsModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    date = json['date'];
    sourceLocationString = json['sourceLocationString'];
    sourceLocationString = json['destinationLocationString'];
    notes = json['notes'];
    paymentValue = json['paymentValue'];
    payloadWeight = json['payloadWeight'];
    packagingType = json['packagingType'];
    materialType = json['materialType'];
    containsLoading = json['containsLoading'];
    containsPacking = json['containsPacking'];
    containsLift = json['containsLift'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (pickupLocationLongitude != null) {
      data['pickupLocationLongitude'] = pickupLocationLongitude;
    }
    if (pickupLocationLatitude != null) {
      data['pickupLocationLatitude'] = pickupLocationLatitude;
    }
    if (destinationLocationLongitude != null) {
      data['destinationLocationLongitude'] = destinationLocationLongitude;
    }
    if (destinationLocationLatitude != null) {
      data['destinationLocationLatitude'] = destinationLocationLatitude;
    }
    if (date != null) data['date'] = date;
    if (notes != null) data['notes'] = notes;
    if (sourceLocationString != null) {
      data['sourceLocationString'] = sourceLocationString;
    }
    if (destinationLocationString != null) {
      data['destinationLocationString'] = destinationLocationString;
    }
    data['payloadWeight'] = payloadWeight.toString();
    data['packagingType'] = packagingType.toString();
    data['materialType'] = materialType.toString();
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }
}
