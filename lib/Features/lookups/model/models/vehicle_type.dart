class VehicleType {
  final String id;
  final String name;
  final List<int> noOfPassengers;

  VehicleType({
    required this.id,
    required this.name,
    required this.noOfPassengers,
  });

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      id: json["id"],
      name: json["name"],
      noOfPassengers: List<int>.from(json["noOfPassengers"]),
    );
  }
}
