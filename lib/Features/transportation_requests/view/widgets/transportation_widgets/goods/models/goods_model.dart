import 'dart:convert';

import 'package:taxi_for_you/Features/lookups/model/lookups_model.dart';
import 'package:taxi_for_you/core/utils/helpers/double_prase.dart';

import '../../../../../model/transportation_base_model.dart';

class GoodsModel extends TransportationBaseModel {
  LookupItem? packagingType;
  LookupItem? materialType;
  double? payloadWeight;
  MaterialDetails? materialDetails;
  PackingDetails? packingDetails;
  bool containsLoading = false;
  bool containsPacking = false;
  bool containsLift = false;

  GoodsModel();

  GoodsModel.fromJson(Map<String, dynamic> json) {
    fromJSON(json);
    if (json['payloadWeight'] != null) {
      payloadWeight = dynamicToDouble(json['payloadWeight']);
    }
    packingDetails = json['packingDetails'] != null
        ? PackingDetails.fromJson(json['packingDetails'])
        : null;
    materialDetails = json['materialDetails'] != null
        ? MaterialDetails.fromJson(json['materialDetails'])
        : null;
    containsLoading = json['containsLoading'] is String
        ? json['containsLoading'] == "true"
        : json['containsLoading'];
    containsPacking = json['containsPacking'] is String
        ? json['containsPacking'] == "true"
        : json['containsPacking'];
    containsLift = json['containsLift'] is String
        ? json['containsLift'] == true
        : json['containsLift'];
  }

  Map<String, dynamic> toGoodsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = toJSON();
    if (payloadWeight != null) {
      data['payloadWeight'] = payloadWeight.toString();
    }
    if (packagingType != null) {
      data['packingType'] = packagingType!.id.toString();
    }
    if (materialType != null) {
      data['materialType'] = materialType!.id.toString();
    }
    data['containsLoading'] = containsLoading.toString();
    data['containsPacking'] = containsPacking.toString();
    data['containsLift'] = containsLift.toString();
    return data;
  }

  GoodsModel copyWith(GoodsModel goodsModel) {
    return GoodsModel.fromJson(goodsModel.toGoodsJson());
  }
}

class MaterialDetails {
  final int id;
  final String? materialType;
  final String? description;

  MaterialDetails({
    required this.id,
    required this.materialType,
    required this.description,
  });

  factory MaterialDetails.fromJson(Map<String, dynamic> json) {
    return MaterialDetails(
      id: json['id'],
      materialType: json['materialType'],
      description: json['description'],
    );
  }
}

class PackingDetails {
  final int id;
  final String? packingType;
  final String? description;

  PackingDetails({
    required this.id,
    required this.packingType,
    required this.description,
  });

  factory PackingDetails.fromJson(Map<String, dynamic> json) {
    return PackingDetails(
      id: json['id'],
      packingType: json['packingType'],
      description: json['description'],
    );
  }
}

class DropdownModel {
  int id;
  String description;

  DropdownModel({required this.id, required this.description});

  factory DropdownModel.fromJson(Map<String, dynamic> json) {
    return DropdownModel(id: json['id'], description: json['description']);
  }

  Map<String, dynamic> toGoodsJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id.toString();
    data['description'] = description;
    return data;
  }
}
