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
  final CarModel carModel;
  final CarManufacturerType carManufacturerType;
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
    required this.carModel,
    required this.carManufacturerType,
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
        dateOfBirth: json['dateOfBirth'],
        driverServiceType: json['driverServiceType'],
        plateNumber: json['plateNumber'],
        rating: json['rating'],
        vehicleType: json['vehicleType'] == null
            ? null
            : DriverVehicleType.fromJson(json['vehicleType']),
        carModel: CarModel.fromJson(json['carModel']),
        carManufacturerType:
            CarManufacturerType.fromJson(json['carManufacturerType']),
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

class CarManufacturerType {
  final int id;
  final String carManufacturer;

  CarManufacturerType({required this.id, required this.carManufacturer});

  factory CarManufacturerType.fromJson(Map<String, dynamic> json) =>
      CarManufacturerType(
        id: json['id'],
        carManufacturer: json['carManufacturer'],
      );
}

class CarModel {
  final int id;
  final CarManufacturerType carManufacturerId;
  final String modelName;

  CarModel({
    required this.id,
    required this.carManufacturerId,
    required this.modelName,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json['id'],
        carManufacturerId:
            CarManufacturerType.fromJson(json['carManufacturerId']),
        modelName: json['modelName'],
      );
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
