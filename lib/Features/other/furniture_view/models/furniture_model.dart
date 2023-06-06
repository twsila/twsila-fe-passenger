import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/Features/google_maps/model/location_model.dart';

class FurnitureModel {
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  String? pickupLocationLongitude;
  String? pickupLocationLatitude;
  String? destinationLocationLongitude;
  String? destinationLocationLatitude;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
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
    date = json['date'];
    sourceLocationString = json['sourceLocationString'];
    sourceLocationString = json['destinationLocationString'];
    notes = json['notes'];
    furnitureItems = FurnitureItems.fromJson(json['furnitureItems']);
    containsLoading = json['containsLoading'];
    containsAssemble = json['containsAssemble'];
    containsPacking = json['containsPacking'];
    containsLift = json['containsLift'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['pickupLocationLongitude'] = pickupLocationLongitude;
    data['pickupLocationLatitude'] = pickupLocationLatitude;
    data['destinationLocationLongitude'] = destinationLocationLongitude;
    data['destinationLocationLatitude'] = destinationLocationLatitude;
    data['date'] = date;
    data['notes'] = notes;
    data['furnitureItems'] = furnitureItems.toJson();
    data['sourceLocationString'] = sourceLocationString;
    data['destinationLocationString'] = destinationLocationString;
    data['containsLoading'] = containsLoading;
    data['containsAssemble'] = containsAssemble;
    data['containsPacking'] = containsPacking;
    data['containsLift'] = containsLift;
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
    data['roomsNumber'] = roomsNumber;
    data['fridgeNumber'] = fridgeNumber;
    data['sofaSetNumber'] = sofaSetNumber;
    data['carpetNumber'] = carpetNumber;
    data['windowAirconditionerNumber'] = windowAirconditionerNumber;
    data['splitAirconditionerNumber'] = splitAirconditionerNumber;
    data['kitchenNumber'] = kitchenNumber;
    data['tablesNumber'] = tablesNumber;
    data['diningRoomNumber'] = diningRoomNumber;
    data['other'] = other;
    return data;
  }
}
