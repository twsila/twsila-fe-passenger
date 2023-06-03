import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/Features/google_maps/model/location_model.dart';

class FurnitureModel {
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  FurnitureItems furnitureItems = FurnitureItems();
  int? paymentValue;
  bool loadingBool = false;
  bool assembleBool = false;
  bool wrappingBool = false;
  bool craneBool = false;
  List<XFile>? images;
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
}
