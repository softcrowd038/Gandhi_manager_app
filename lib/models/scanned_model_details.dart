// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

ScannedModelDetails scannedModelDetailsFromJson(String str) =>
    ScannedModelDetails.fromJson(json.decode(str));

String scannedModelDetailsToJson(ScannedModelDetails data) =>
    json.encode(data.toJson());

class ScannedModelDetails {
  String status;
  Data data;

  ScannedModelDetails({required this.status, required this.data});

  factory ScannedModelDetails.fromJson(Map<String, dynamic> json) =>
      ScannedModelDetails(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data.toJson()};
}

class Data {
  Vehicle vehicle;

  Data({required this.vehicle});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(vehicle: Vehicle.fromJson(json["vehicle"]));

  Map<String, dynamic> toJson() => {"vehicle": vehicle.toJson()};
}

class Vehicle {
  String? id;
  Model? model;
  UnloadLocation? unloadLocation;
  String? type;
  List<Color> colors;
  String? batteryNumber;
  String? keyNumber;
  String? chassisNumber;
  String? motorNumber;
  String? chargerNumber;
  String? engineNumber;
  bool? hasDamage;
  List<dynamic> damages;
  String? status;
  AddedBy? addedBy;
  DateTime? addedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? qrCode;
  int? v;
  String? vehicleId;

  Vehicle({
    required this.id,
    required this.model,
    required this.unloadLocation,
    required this.type,
    required this.colors,
    required this.batteryNumber,
    required this.keyNumber,
    required this.chassisNumber,
    required this.motorNumber,
    required this.chargerNumber,
    required this.engineNumber,
    required this.hasDamage,
    required this.damages,
    required this.status,
    required this.addedBy,
    required this.addedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.qrCode,
    required this.v,
    required this.vehicleId,
  });

  factory Vehicle.fromJson(Map<String?, dynamic>? json) => Vehicle(
    id: json?["_id"],
    model: Model.fromJson(json?["model"]),
    unloadLocation: UnloadLocation.fromJson(json?["unloadLocation"]),
    type: json?["type"],
    colors: List<Color>.from(json?["colors"].map((x) => Color.fromJson(x))),
    batteryNumber: json?["batteryNumber"],
    keyNumber: json?["keyNumber"],
    chassisNumber: json?["chassisNumber"],
    motorNumber: json?["motorNumber"],
    chargerNumber: json?["chargerNumber"],
    engineNumber: json?["engineNumber"],
    hasDamage: json?["hasDamage"],
    damages: List<dynamic>.from(json?["damages"].map((x) => x)),
    status: json?["status"],
    addedBy: AddedBy.fromJson(json?["addedBy"]),
    addedAt: DateTime.parse(json?["addedAt"]),
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    qrCode: json?["qrCode"],
    v: json?["__v"],
    vehicleId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model": model?.toJson(),
    "unloadLocation": unloadLocation?.toJson(),
    "type": type,
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
    "batteryNumber": batteryNumber,
    "keyNumber": keyNumber,
    "chassisNumber": chassisNumber,
    "motorNumber": motorNumber,
    "chargerNumber": chargerNumber,
    "engineNumber": engineNumber,
    "hasDamage": hasDamage,
    "damages": List<dynamic>.from(damages.map((x) => x)),
    "status": status,
    "addedBy": addedBy?.toJson(),
    "addedAt": addedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "qrCode": qrCode,
    "__v": v,
    "id": vehicleId,
  };
}

class AddedBy {
  String? id;
  String? name;
  String? email;
  String? addedById;

  AddedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.addedById,
  });

  factory AddedBy.fromJson(Map<String?, dynamic>? json) => AddedBy(
    id: json?["_id"],
    name: json?["name"],
    email: json?["email"],
    addedById: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "id": addedById,
  };
}

class Color {
  String? id;
  String? name;
  String? hexCode;
  String? status;
  List<String> models;
  DateTime? createdAt;
  String? colorId;

  Color({
    required this.id,
    required this.name,
    required this.hexCode,
    required this.status,
    required this.models,
    required this.createdAt,
    required this.colorId,
  });

  factory Color.fromJson(Map<String?, dynamic>? json) => Color(
    id: json?["_id"],
    name: json?["name"],
    hexCode: json?["hex_code"],
    status: json?["status"],
    models: List<String>.from(json?["models"].map((x) => x)),
    createdAt: DateTime.parse(json?["createdAt"]),
    colorId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "hex_code": hexCode,
    "status": status,
    "models": List<dynamic>.from(models.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "id": colorId,
  };
}

class Model {
  String? id;
  String? modelName;
  String? type;
  String? status;
  List<Price> prices;
  List<String> colors;
  DateTime? createdAt;
  String? modelId;

  Model({
    required this.id,
    required this.modelName,
    required this.type,
    required this.status,
    required this.prices,
    required this.colors,
    required this.createdAt,
    required this.modelId,
  });

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    id: json?["_id"],
    modelName: json?["model_name"],
    type: json?["type"],
    status: json?["status"],
    prices: List<Price>.from(json?["prices"].map((x) => Price.fromJson(x))),
    colors: List<String>.from(json?["colors"].map((x) => x)),
    createdAt: DateTime.parse(json?["createdAt"]),
    modelId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "type": type,
    "status": status,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "id": modelId,
  };
}

class Price {
  int? value;
  String? headerId;
  Id? branchId;

  Price({required this.value, required this.headerId, required this.branchId});

  factory Price.fromJson(Map<String?, dynamic>? json) => Price(
    value: json?["value"],
    headerId: json?["header_id"],
    branchId: idValues.map?[json?["branch_id"]]!,
  );

  Map<String?, dynamic>? toJson() => {
    "value": value,
    "header_id": headerId,
    "branch_id": idValues.reverse?[branchId],
  };
}

enum Id { THE_685641_B4_A584_A450570_F20_AE }

final idValues = EnumValues({
  "685641b4a584a450570f20ae": Id.THE_685641_B4_A584_A450570_F20_AE,
});

class UnloadLocation {
  Id id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? phone;
  String? email;
  String? gstNumber;
  bool? isActive;
  Id? unloadLocationId;

  UnloadLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
    required this.email,
    required this.gstNumber,
    required this.isActive,
    required this.unloadLocationId,
  });

  factory UnloadLocation.fromJson(Map<String?, dynamic>? json) =>
      UnloadLocation(
        id: idValues.map?[json?["_id"]] ?? Id.THE_685641_B4_A584_A450570_F20_AE,
        name: json?["name"],
        address: json?["address"],
        city: json?["city"],
        state: json?["state"],
        pincode: json?["pincode"],
        phone: json?["phone"],
        email: json?["email"],
        gstNumber: json?["gst_number"],
        isActive: json?["is_active"],
        unloadLocationId: idValues.map?[json?["id"]]!,
      );

  Map<String?, dynamic>? toJson() => {
    "_id": idValues.reverse?[id],
    "name": name,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "phone": phone,
    "email": email,
    "gst_number": gstNumber,
    "is_active": isActive,
    "id": idValues.reverse?[unloadLocationId],
  };
}

class EnumValues<T> {
  Map<String?, T>? map;
  late Map<T?, String>? reverseMap;

  EnumValues(this.map);

  Map<T?, String>? get reverse {
    reverseMap = map?.map((k, v) => MapEntry(v, k ?? ""));
    return reverseMap;
  }
}
