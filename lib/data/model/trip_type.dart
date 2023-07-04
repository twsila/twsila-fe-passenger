enum TripType {
  furniture,
  freezers,
  goods,
  waterTank,
  carAid,
  cisterns,
}

extension GetTripTypeFromString on TripType {
  TripType getTripType(String type) {
    switch (type) {
      case 'FURNITURE':
        return TripType.furniture;
      case 'GOODS':
        return TripType.goods;
      case 'FROZEN':
        return TripType.freezers;
      case 'CAR_AID':
        return TripType.carAid;
      case 'DRINK_WATER_TANK':
        return TripType.waterTank;
      case 'OTHER_TANK':
        return TripType.cisterns;
      default:
        return TripType.furniture;
    }
  }
}
