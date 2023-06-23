import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class FurnitureModel {
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? stringDate;
  String? pickupLocationName;
  String? destinationLocationName;
  String? notes;
  FurnitureItems furnitureItems = FurnitureItems();
  int? paymentValue;
  bool containsLoading = false;
  bool containsAssemble = false;
  bool containsPacking = false;
  bool containsLift = false;
  List<XFile>? images;

  FurnitureModel();

  FurnitureModel.fromJson(Map<String, dynamic> json) {
    pickupLocationLongitude = json['pickupLocationLongitude'];
    pickupLocationLatitude = json['pickupLocationLatitude'];
    destinationLocationLongitude = json['destinationLocationLongitude'];
    destinationLocationLatitude = json['destinationLocationLatitude'];
    stringDate = json['date'];
    pickupLocationName = json['pickupLocationName'];
    pickupLocationName = json['destinationLocationName'];
    notes = json['notes'];
    furnitureItems = FurnitureItems.fromJson(json['furnitureItems']);
    paymentValue = json['clientOffer'];
    containsLoading = json['containsLoading'];
    containsAssemble = json['containsAssemble'];
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
    if (date != null) data['date'] = stringDate;
    if (notes != null) data['notes'] = notes;
    data['furnitureItems'] = json.encode(furnitureItems.toJson());
    if (pickupLocationName != null) {
      data['pickupLocationName'] = pickupLocationName;
    }
    if (destinationLocationName != null) {
      data['destinationLocationName'] = destinationLocationName;
    }
    data['clientOffer'] = paymentValue.toString();
    data['containsLoading'] = containsLoading.toString();
    data['containsAssemble'] = containsAssemble.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }
}

class FurnitureItems {
  int roomsNumber = 0;
  int fridgeNumber = 0;
  int sofaSetNumber = 0;
  int carpetNumber = 0;
  int windowAirconditionerNumber = 0;
  int splitAirconditionerNumber = 0;
  int kitchenNumber = 0;
  int tablesNumber = 0;
  int diningRoomNumber = 0;
  int other = 0;

  FurnitureItems();

  FurnitureItems.fromJson(Map<String, dynamic> json) {
    roomsNumber = json['roomsNumber'];
    fridgeNumber = json['fridgeNumber'];
    sofaSetNumber = json['sofaSetNumber'];
    carpetNumber = json['carpetNumber'];
    windowAirconditionerNumber = json['windowAirconditionerNumber'];
    splitAirconditionerNumber = json['splitAirconditionerNumber'];
    kitchenNumber = json['kitchenNumber'];
    tablesNumber = json['tablesNumber'];
    diningRoomNumber = json['diningRoomNumber'];
    other = json['other'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['roomsNumber'] = roomsNumber.toString();
    data['fridgeNumber'] = fridgeNumber.toString();
    data['sofaSetNumber'] = sofaSetNumber.toString();
    data['carpetNumber'] = carpetNumber.toString();
    data['windowAirconditionerNumber'] = windowAirconditionerNumber.toString();
    data['splitAirconditionerNumber'] = splitAirconditionerNumber.toString();
    data['kitchenNumber'] = kitchenNumber.toString();
    data['tablesNumber'] = tablesNumber.toString();
    data['diningRoomNumber'] = diningRoomNumber.toString();
    data['other'] = other.toString();
    return data;
  }
}
