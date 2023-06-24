import 'dart:convert';
import 'package:taxi_for_you/Features/transportation_requests/common/common_repo/transportation_base_model.dart';

class FurnitureModel extends TransportationBaseModel {
  FurnitureItems furnitureItems = FurnitureItems();
  bool containsLoading = false;
  bool containsAssemble = false;
  bool containsPacking = false;
  bool containsLift = false;

  FurnitureModel();

  FurnitureModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    furnitureItems = FurnitureItems.fromJson(json['furnitureItems']);
    containsLoading = json['containsLoading'];
    containsAssemble = json['containsAssemble'];
    containsPacking = json['containsPacking'];
    containsLift = json['containsLift'];
  }

  Map<String, dynamic> toFurnitureJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    data['furnitureItems'] = json.encode(furnitureItems.toJson());
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
