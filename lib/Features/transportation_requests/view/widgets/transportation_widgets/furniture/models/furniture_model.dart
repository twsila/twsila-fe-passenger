import 'dart:convert';

import '../../../../../model/transportation_base_model.dart';

class FurnitureModel extends TransportationBaseModel {
  FurnitureItems furnitureItems = FurnitureItems();
  bool containsLoading = false;
  bool containsAssemble = false;
  bool containsPacking = false;
  bool containsLift = false;

  FurnitureModel();

  FurnitureModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    furnitureItems =
        FurnitureItems.fromJson(jsonDecode(json['furnitureItems']));
    containsLoading = json['containsLoading'] == 'true';
    containsAssemble = json['containsAssemble'] == 'true';
    containsPacking = json['containsPacking'] == 'true';
    containsLift = json['containsLift'] == 'true';
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
    roomsNumber = int.parse(json['roomsNumber']);
    fridgeNumber = int.parse(json['fridgeNumber']);
    sofaSetNumber = int.parse(json['sofaSetNumber']);
    carpetNumber = int.parse(json['carpetNumber']);
    windowAirconditionerNumber = int.parse(json['windowAirconditionerNumber']);
    splitAirconditionerNumber = int.parse(json['splitAirconditionerNumber']);
    kitchenNumber = int.parse(json['kitchenNumber']);
    tablesNumber = int.parse(json['tablesNumber']);
    diningRoomNumber = int.parse(json['diningRoomNumber']);
    other = int.parse(json['other']);
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
