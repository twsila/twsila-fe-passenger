import 'package:flutter/material.dart';
import '../models/furniture_model.dart';

class FurnitureViewModel {
  FurnitureModel furnitureModel = FurnitureModel();
  ValueNotifier<bool> firstScreenValid = ValueNotifier(false);

  start(FurnitureModel furnitureModel) {
    this.furnitureModel = furnitureModel;
  }

  bool validateFirstScreen() {
    return !(furnitureModel.furnitureItems.roomsNumber == 0 &&
        furnitureModel.furnitureItems.fridgeNumber == 0 &&
        furnitureModel.furnitureItems.sofaSetNumber == 0 &&
        furnitureModel.furnitureItems.carpetNumber == 0 &&
        furnitureModel.furnitureItems.windowAirconditionerNumber == 0 &&
        furnitureModel.furnitureItems.splitAirconditionerNumber == 0 &&
        furnitureModel.furnitureItems.kitchenNumber == 0 &&
        furnitureModel.furnitureItems.tablesNumber == 0 &&
        furnitureModel.furnitureItems.diningRoomNumber == 0 &&
        furnitureModel.furnitureItems.other == 0);
  }

  bool validateSecondScreen() {
    return furnitureModel.pickupLocationLatitude != null &&
        furnitureModel.pickupLocationLongitude != null &&
        furnitureModel.destinationLocationLatitude != null &&
        furnitureModel.destinationLocationLongitude != null;
  }
}
