import 'package:image_picker/image_picker.dart';
import 'package:taxi_for_you/presentation/google_maps/model/location_model.dart';

class FurnitureModel {
  LocationModel? sourceLocation;
  LocationModel? destinationLocation;
  String? date;
  String? sourceLocationString;
  String? destinationLocationString;
  String? notes;
  int? roomsNumber;
  int? fridgeNumber;
  int? chairsNumber;
  int? carpetsNumber;
  int? airconditionerNumber;
  int? kitchenNumber;
  int? diningRoomNumber;
  int? paymentValue;
  bool loadingBool = false;
  bool assembleBool = false;
  bool wrappingBool = false;
  bool craneBool = false;
  List<XFile>? images;
}
