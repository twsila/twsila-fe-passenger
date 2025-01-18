class DriverModel {
  final int driverId;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String gender;
  final String? dateOfBirth;
  final String? driverServiceType;
  final String plateNumber;
  final double rating;
  final DriverVehicleType? vehicleType;
  CarModel? carModel;
  CarManufacturerModel? carManufacturerType;
  final bool canTransportFurniture;
  final bool canTransportGoods;
  final bool canTransportFrozen;
  final bool hasWaterTank;
  final bool hasOtherTanks;
  final bool hasPacking;
  final bool hasLoading;
  final bool hasAssembly;
  final bool hasLifting;
  final DriverImages? image;

  DriverModel({
    required this.driverId,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.gender,
    required this.dateOfBirth,
    required this.driverServiceType,
    required this.plateNumber,
    required this.rating,
    required this.vehicleType,
    this.carModel,
    this.carManufacturerType,
    required this.canTransportFurniture,
    required this.canTransportGoods,
    required this.canTransportFrozen,
    required this.hasWaterTank,
    required this.hasOtherTanks,
    required this.hasPacking,
    required this.hasLoading,
    required this.hasAssembly,
    required this.hasLifting,
    this.image,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        driverId: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        mobile: json['mobile'],
        email: json['email'],
        gender: json['gender'],
        dateOfBirth: json['dateOfBirth'] ?? "",
        driverServiceType: json['driverServiceType'],
        plateNumber: json['plateNumber'],
        rating: json['rating'],
        vehicleType: json['vehicleType'] == null
            ? null
            : DriverVehicleType.fromJson(json['vehicleType']),
        carModel: json['carModel'] != null
            ? CarModel.fromJson(json['carModel'])
            : null,
        carManufacturerType: json['carManufacturer'] != null
            ? CarManufacturerModel.fromJson(json['carManufacturer'])
            : null,
        canTransportFurniture: json['canTransportFurniture'],
        canTransportGoods: json['canTransportGoods'],
        canTransportFrozen: json['canTransportFrozen'],
        hasWaterTank: json['hasWaterTank'],
        hasOtherTanks: json['hasOtherTanks'],
        hasPacking: json['hasPacking'],
        hasLoading: json['hasLoading'],
        hasAssembly: json['hasAssembly'],
        hasLifting: json['hasLifting'],
        image: DriverImages.fromJson(json['images'][0]),
      );
}

class DriverVehicleType {
  final int vehicleId;
  final String? vehicleType;
  final String? driverServiceType;

  DriverVehicleType({
    required this.vehicleId,
    this.vehicleType,
    this.driverServiceType,
  });

  factory DriverVehicleType.fromJson(Map<String, dynamic> json) =>
      DriverVehicleType(
        vehicleId: json['id'],
        vehicleType: json['vehicleType'],
        driverServiceType: json['driverServiceType'],
      );
}

class CarManufacturerModel {
  int id;
  bool showInTwsila;
  String carManufacturerEn;
  String carManufacturerAr;

  CarManufacturerModel({
    required this.id,
    required this.showInTwsila,
    required this.carManufacturerEn,
    required this.carManufacturerAr,
  });

  factory CarManufacturerModel.fromJson(Map<String, dynamic> json) =>
      CarManufacturerModel(
        id: json["id"],
        showInTwsila: json["showInTwsila"],
        carManufacturerEn: json["carManufacturerEn"],
        carManufacturerAr: json["carManufacturerAr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "showInTwsila": showInTwsila,
        "carManufacturerEn": carManufacturerEn,
        "carManufacturerAr": carManufacturerAr,
      };
}

class CarModel {
  int id;
  CarManufacturerModel carManufacturer;
  String modelName;
  String modelNameAr;

  CarModel({
    required this.id,
    required this.carManufacturer,
    required this.modelName,
    required this.modelNameAr,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        carManufacturer: CarManufacturerModel.fromJson(json["carManufacturer"]),
        modelName: json["modelName"],
        modelNameAr: json["modelNameAr"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carManufacturer": carManufacturer.toJson(),
        "modelName": modelName,
        "modelNameAr": modelNameAr,
      };
}

class DriverImages {
  final int? id;
  final String? imageName;
  final String? imageURL;

  DriverImages({
    this.id,
    this.imageName,
    this.imageURL,
  });

  factory DriverImages.fromJson(Map<String, dynamic> json) => DriverImages(
        id: json['id'],
        imageName: json['imageName'],
        imageURL: json['imageURL'],
      );
}
