import 'package:image_picker/image_picker.dart';

class Results {
  String? date;
  String? sourceLocation;
  String? destinationLocation;
  String? notes;
  int? roomsNumber;
  int? fridgeNumber;
  int? chairsNumber;
  int? carpetsNumber;
  int? airconditionerNumber;
  int? kitchenNumber;
  int? diningRoomNumber;
  bool loadingBool = false;
  bool assembleBool = false;
  bool wrappingBool = false;
  bool craneBool = false;
  List<XFile>? images;

  /* --------------------- A Singleton class for handling results --------------------- */
  static final Results _instance = Results._internal();
  factory Results() => _instance;
  Results._internal();
}
