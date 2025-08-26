// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

InwardModelDetails inwardModelDetailsFromJson(String? str) =>
    InwardModelDetails.fromJson(json.decode(str ?? ""));

String? inwardModelDetailsToJson(InwardModelDetails data) =>
    json.encode(data.toJson());

class InwardModelDetails {
  String? status;
  int? results;
  Data? data;

  InwardModelDetails({
    required this.status,
    required this.results,
    required this.data,
  });

  factory InwardModelDetails.fromJson(Map<String?, dynamic>? json) =>
      InwardModelDetails(
        status: json?["status"],
        results: json?["results"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };
}

class Data {
  List<Vehicle> vehicles;

  Data({required this.vehicles});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    vehicles: List<Vehicle>.from(
      json?["vehicles"].map((x) => Vehicle.fromJson(x)),
    ),
  );

  Map<String?, dynamic>? toJson() => {
    "vehicles": List<dynamic>.from(vehicles.map((x) => x.toJson())),
  };
}

class Vehicle {
  Color? color;
  String? id;
  String? model;
  String? modelName;
  UnloadLocation unloadLocation;
  Type? type;
  List<String?> colors;
  String? batteryNumber;
  String? keyNumber;
  String? chassisNumber;
  String? motorNumber;
  String? chargerNumber;
  String? engineNumber;
  bool? hasDamage;
  List<dynamic> damages;
  Status? status;
  AddedBy? addedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? qrCode;
  int? v;
  LastUpdatedByEnum? lastUpdatedBy;
  String? vehicleId;

  Vehicle({
    required this.color,
    required this.id,
    this.model,
    required this.modelName,
    required this.unloadLocation,
    required this.type,
    required this.colors,
    required this.batteryNumber,
    required this.keyNumber,
    required this.chassisNumber,
    this.motorNumber,
    this.chargerNumber,
    required this.engineNumber,
    required this.hasDamage,
    required this.damages,
    required this.status,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.qrCode,
    required this.v,
    this.lastUpdatedBy,
    required this.vehicleId,
  });

  factory Vehicle.fromJson(Map<String?, dynamic>? json) => Vehicle(
    color: Color.fromJson(json?["color"]),
    id: json?["_id"],
    model: json?["model"],
    modelName: json?["modelName"],
    unloadLocation: UnloadLocation.fromJson(json?["unloadLocation"]),
    type: typeValues.map[json?["type"]],
    colors: List<String?>.from(json?["colors"].map((x) => x)),
    batteryNumber: json?["batteryNumber"],
    keyNumber: json?["keyNumber"],
    chassisNumber: json?["chassisNumber"],
    motorNumber: json?["motorNumber"],
    chargerNumber: json?["chargerNumber"],
    engineNumber: json?["engineNumber"],
    hasDamage: json?["hasDamage"],
    damages: List<dynamic>.from(json?["damages"].map((x) => x)),
    status: statusValues.map[json?["status"]],
    addedBy: AddedBy.fromJson(json?["addedBy"]),
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    qrCode: json?["qrCode"],
    v: json?["__v"],
    lastUpdatedBy: lastUpdatedByEnumValues.map[json?["lastUpdatedBy"]],
    vehicleId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "color": color?.toJson(),
    "_id": id,
    "model": model,
    "modelName": modelName,
    "unloadLocation": unloadLocation.toJson(),
    "type": typeValues.reverse[type],
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "batteryNumber": batteryNumber,
    "keyNumber": keyNumber,
    "chassisNumber": chassisNumber,
    "motorNumber": motorNumber,
    "chargerNumber": chargerNumber,
    "engineNumber": engineNumber,
    "hasDamage": hasDamage,
    "damages": List<dynamic>.from(damages.map((x) => x)),
    "status": statusValues.reverse[status],
    "addedBy": addedBy?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "qrCode": qrCode,
    "__v": v,
    "lastUpdatedBy": lastUpdatedByEnumValues.reverse[lastUpdatedBy],
    "id": vehicleId,
  };
}

class AddedBy {
  LastUpdatedByEnum? id;
  AddedByName? name;
  AddedByEmail? email;
  LastUpdatedByEnum? addedById;

  AddedBy({
    required this.id,
    required this.name,
    required this.email,
    required this.addedById,
  });

  factory AddedBy.fromJson(Map<String?, dynamic>? json) => AddedBy(
    id: lastUpdatedByEnumValues.map[json?["_id"]],
    name: addedByNameValues.map[json?["name"]],
    email: addedByEmailValues.map[json?["email"]],
    addedById: lastUpdatedByEnumValues.map[json?["id"]],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": lastUpdatedByEnumValues.reverse[id],
    "name": addedByNameValues.reverse[name],
    "email": addedByEmailValues.reverse[email],
    "id": lastUpdatedByEnumValues.reverse[addedById],
  };
}

enum LastUpdatedByEnum { THE_68554_A1_F12_D0_C8279_C3867_FB }

final lastUpdatedByEnumValues = EnumValues({
  "68554a1f12d0c8279c3867fb":
      LastUpdatedByEnum.THE_68554_A1_F12_D0_C8279_C3867_FB,
});

enum AddedByEmail { JOHN_EXAMPLE_COM }

final addedByEmailValues = EnumValues({
  "john@example.com": AddedByEmail.JOHN_EXAMPLE_COM,
});

enum AddedByName { JOHN_DOE }

final addedByNameValues = EnumValues({"John Doe": AddedByName.JOHN_DOE});

class Color {
  String? id;
  String? name;

  Color({required this.id, required this.name});

  factory Color.fromJson(Map<String?, dynamic>? json) =>
      Color(id: json?["id"], name: json?["name"]);

  Map<String?, dynamic>? toJson() => {"id": id, "name": name};
}

enum Status { IN_STOCK, NOT_APPROVED }

final statusValues = EnumValues({
  "in_stock": Status.IN_STOCK,
  "not_approved": Status.NOT_APPROVED,
});

enum Type { ICE }

final typeValues = EnumValues({"ICE": Type.ICE});

class UnloadLocation {
  UnloadLocationId? id;
  UnloadLocationName? name;
  Address? address;
  City? city;
  City? state;
  String? pincode;
  String? phone;
  UnloadLocationEmail? email;
  GstNumber? gstNumber;
  bool? isActive;
  UnloadLocationId? unloadLocationId;

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
        id: unloadLocationIdValues.map[json?["_id"]],
        name: unloadLocationNameValues.map[json?["name"]],
        address: addressValues.map[json?["address"]],
        city: cityValues.map[json?["city"]],
        state: cityValues.map[json?["state"]],
        pincode: json?["pincode"],
        phone: json?["phone"],
        email: unloadLocationEmailValues.map[json?["email"]],
        gstNumber: gstNumberValues.map[json?["gst_number"]],
        isActive: json?["is_active"],
        unloadLocationId: unloadLocationIdValues.map[json?["id"]],
      );

  Map<String?, dynamic>? toJson() => {
    "_id": unloadLocationIdValues.reverse[id],
    "name": unloadLocationNameValues.reverse[name],
    "address": addressValues.reverse[address],
    "city": cityValues.reverse[city],
    "state": cityValues.reverse[state],
    "pincode": pincode,
    "phone": phone,
    "email": unloadLocationEmailValues.reverse[email],
    "gst_number": gstNumberValues.reverse[gstNumber],
    "is_active": isActive,
    "id": unloadLocationIdValues.reverse[unloadLocationId],
  };
}

enum Address { PUNE1 }

final addressValues = EnumValues({"Pune1": Address.PUNE1});

enum City { PUNE }

final cityValues = EnumValues({"Pune": City.PUNE});

enum UnloadLocationEmail { EMAIL12_GMAIL_COM }

final unloadLocationEmailValues = EnumValues({
  "email12@gmail.com": UnloadLocationEmail.EMAIL12_GMAIL_COM,
});

enum GstNumber { THE_27_AAAAP0267_H2_ZN }

final gstNumberValues = EnumValues({
  "27AAAAP0267H2ZN": GstNumber.THE_27_AAAAP0267_H2_ZN,
});

enum UnloadLocationId { THE_685641_B4_A584_A450570_F20_AE }

final unloadLocationIdValues = EnumValues({
  "685641b4a584a450570f20ae":
      UnloadLocationId.THE_685641_B4_A584_A450570_F20_AE,
});

enum UnloadLocationName { CIDCO_NASHIK }

final unloadLocationNameValues = EnumValues({
  "Cidco Nashik": UnloadLocationName.CIDCO_NASHIK,
});

class EnumValues<T> {
  Map<String?, T> map;
  late Map<T, String?> reverseMap;

  EnumValues(this.map);

  Map<T, String?> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
