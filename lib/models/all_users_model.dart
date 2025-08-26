import '../common/app_imports.dart';

AllUsersModel allUsersModelFromJson(String? str) =>
    AllUsersModel.fromJson(json.decode(str ?? "{}"));

String? allUsersModelToJson(AllUsersModel data) => json.encode(data.toJson());

class AllUsersModel {
  bool? success;
  List<Datum> data;

  AllUsersModel({this.success, required this.data});

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    return AllUsersModel(
      success: json["success"] as bool?,
      data: json["data"] != null
          ? List<Datum>.from(
              (json["data"] as List).map((x) => Datum.fromJson(x)),
            )
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  String? email;
  String? mobile;
  List<Role> roles;
  bool? isActive;
  List<String> loginIPs;
  List<Permission> permissions;
  List<dynamic> delegatedAccess;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastLogin;
  int? discount;
  List<BufferExtension> bufferExtensions;
  DateTime? documentBufferTime;
  String? freezeReason;
  bool? isFrozen;
  String? status;
  String? branch;
  List<dynamic> userDelegatedPermissions;
  List<dynamic> userDirectPermissions;
  BranchDetails? branchDetails;
  SubdealerDetails? subdealerDetails;
  String? datumId;
  String? subdealer;

  Datum({
    this.id,
    this.name,
    this.email,
    this.mobile,
    required this.roles,
    this.isActive,
    required this.loginIPs,
    required this.permissions,
    required this.delegatedAccess,
    this.createdAt,
    this.updatedAt,
    this.lastLogin,
    this.discount,
    required this.bufferExtensions,
    this.documentBufferTime,
    this.freezeReason,
    this.isFrozen,
    this.status,
    this.branch,
    required this.userDelegatedPermissions,
    required this.userDirectPermissions,
    this.branchDetails,
    this.subdealerDetails,
    this.datumId,
    this.subdealer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      mobile: json["mobile"] as String?,
      roles: json["roles"] != null
          ? List<Role>.from(
              (json["roles"] as List).map((x) => Role.fromJson(x)),
            )
          : [],
      isActive: json["isActive"] as bool?,
      loginIPs: json["loginIPs"] != null
          ? List<String>.from(
              (json["loginIPs"] as List).map((x) => x.toString()),
            )
          : [],
      permissions: json["permissions"] != null
          ? List<Permission>.from(
              (json["permissions"] as List).map((x) => Permission.fromJson(x)),
            )
          : [],
      delegatedAccess: json["delegatedAccess"] != null
          ? List<dynamic>.from(json["delegatedAccess"] as List)
          : [],
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
      lastLogin: json["lastLogin"] != null
          ? DateTime.tryParse(json["lastLogin"])
          : null,
      discount: json["discount"] as int?,
      bufferExtensions: json["bufferExtensions"] != null
          ? List<BufferExtension>.from(
              (json["bufferExtensions"] as List).map(
                (x) => BufferExtension.fromJson(x),
              ),
            )
          : [],
      documentBufferTime: json["documentBufferTime"] != null
          ? DateTime.tryParse(json["documentBufferTime"])
          : null,
      freezeReason: json["freezeReason"] as String?,
      isFrozen: json["isFrozen"] as bool?,
      status: json["status"] as String?,
      branch: json["branch"] as String?,
      userDelegatedPermissions: json["userDelegatedPermissions"] != null
          ? List<dynamic>.from(json["userDelegatedPermissions"] as List)
          : [],
      userDirectPermissions: json["userDirectPermissions"] != null
          ? List<dynamic>.from(json["userDirectPermissions"] as List)
          : [],
      branchDetails: json["branchDetails"] != null
          ? BranchDetails.fromJson(json["branchDetails"])
          : null,
      subdealerDetails: json["subdealerDetails"] != null
          ? SubdealerDetails.fromJson(json["subdealerDetails"])
          : null,
      datumId: json["id"] as String?,
      subdealer: json["subdealer"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "isActive": isActive,
    "loginIPs": List<dynamic>.from(loginIPs.map((x) => x)),
    "permissions": List<dynamic>.from(permissions.map((x) => x.toJson())),
    "delegatedAccess": List<dynamic>.from(delegatedAccess.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "lastLogin": lastLogin?.toIso8601String(),
    "discount": discount,
    "bufferExtensions": List<dynamic>.from(
      bufferExtensions.map((x) => x.toJson()),
    ),
    "documentBufferTime": documentBufferTime?.toIso8601String(),
    "freezeReason": freezeReason,
    "isFrozen": isFrozen,
    "status": status,
    "branch": branch,
    "userDelegatedPermissions": List<dynamic>.from(
      userDelegatedPermissions.map((x) => x),
    ),
    "userDirectPermissions": List<dynamic>.from(
      userDirectPermissions.map((x) => x),
    ),
    "branchDetails": branchDetails?.toJson(),
    "subdealerDetails": subdealerDetails?.toJson(),
    "id": datumId,
    "subdealer": subdealer,
  };
}

class BranchDetails {
  String? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? branchDetailsId;

  BranchDetails({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.branchDetailsId,
  });

  factory BranchDetails.fromJson(Map<String, dynamic> json) {
    return BranchDetails(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      address: json["address"] as String?,
      city: json["city"] as String?,
      state: json["state"] as String?,
      branchDetailsId: json["id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "city": city,
    "state": state,
    "id": branchDetailsId,
  };
}

class BufferExtension {
  String? extendedBy;
  DateTime? newBufferTime;
  String? reason;
  String? id;
  DateTime? extendedAt;
  String? bufferExtensionId;

  BufferExtension({
    this.extendedBy,
    this.newBufferTime,
    this.reason,
    this.id,
    this.extendedAt,
    this.bufferExtensionId,
  });

  factory BufferExtension.fromJson(Map<String, dynamic> json) {
    return BufferExtension(
      extendedBy: json["extendedBy"] as String?,
      newBufferTime: json["newBufferTime"] != null
          ? DateTime.tryParse(json["newBufferTime"])
          : null,
      reason: json["reason"] as String?,
      id: json["_id"] as String?,
      extendedAt: json["extendedAt"] != null
          ? DateTime.tryParse(json["extendedAt"])
          : null,
      bufferExtensionId: json["id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "extendedBy": extendedBy,
    "newBufferTime": newBufferTime?.toIso8601String(),
    "reason": reason,
    "_id": id,
    "extendedAt": extendedAt?.toIso8601String(),
    "id": bufferExtensionId,
  };
}

class Permission {
  String? permission;
  String? grantedBy;
  dynamic expiresAt;
  String? id;
  String? permissionId;

  Permission({
    this.permission,
    this.grantedBy,
    this.expiresAt,
    this.id,
    this.permissionId,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      permission: json["permission"] as String?,
      grantedBy: json["grantedBy"] as String?,
      expiresAt: json["expiresAt"],
      id: json["_id"] as String?,
      permissionId: json["id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "permission": permission,
    "grantedBy": grantedBy,
    "expiresAt": expiresAt,
    "_id": id,
    "id": permissionId,
  };
}

class Role {
  String? id;
  String? name;
  int? v;
  DateTime? createdAt;
  String? description;
  List<dynamic> inheritedRoles;
  bool? isSuperAdmin;
  bool? roleIsActive;
  List<String> permissions;
  DateTime? updatedAt;
  bool? isActive;
  List<dynamic> inherits;
  String? createdBy;

  Role({
    this.id,
    this.name,
    this.v,
    this.createdAt,
    this.description,
    required this.inheritedRoles,
    this.isSuperAdmin,
    this.roleIsActive,
    required this.permissions,
    this.updatedAt,
    this.isActive,
    required this.inherits,
    this.createdBy,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      v: json["__v"] as int?,
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      description: json["description"] as String?,
      inheritedRoles: json["inheritedRoles"] != null
          ? List<dynamic>.from(json["inheritedRoles"] as List)
          : [],
      isSuperAdmin: json["isSuperAdmin"] as bool?,
      roleIsActive: json["is_active"] as bool?,
      permissions: json["permissions"] != null
          ? List<String>.from(
              (json["permissions"] as List).map((x) => x.toString()),
            )
          : [],
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
      isActive: json["isActive"] as bool?,
      inherits: json["inherits"] != null
          ? List<dynamic>.from(json["inherits"] as List)
          : [],
      createdBy: json["createdBy"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "inheritedRoles": List<dynamic>.from(inheritedRoles.map((x) => x)),
    "isSuperAdmin": isSuperAdmin,
    "is_active": roleIsActive,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "updatedAt": updatedAt?.toIso8601String(),
    "isActive": isActive,
    "inherits": List<dynamic>.from(inherits.map((x) => x)),
    "createdBy": createdBy,
  };
}

class SubdealerDetails {
  String? id;
  String? name;
  String? location;
  String? type;
  int? discount;
  String? subdealerDetailsId;

  SubdealerDetails({
    this.id,
    this.name,
    this.location,
    this.type,
    this.discount,
    this.subdealerDetailsId,
  });

  factory SubdealerDetails.fromJson(Map<String, dynamic> json) {
    return SubdealerDetails(
      id: json["_id"] as String?,
      name: json["name"] as String?,
      location: json["location"] as String?,
      type: json["type"] as String?,
      discount: json["discount"] as int?,
      subdealerDetailsId: json["id"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
    "type": type,
    "discount": discount,
    "id": subdealerDetailsId,
  };
}
