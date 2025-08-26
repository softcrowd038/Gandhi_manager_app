import 'package:gandhi_tvs/common/app_imports.dart';

UserDetails userDetailsFromJson(String? str) =>
    UserDetails.fromJson(json.decode(str ?? ""));

String userDetailsToJson(UserDetails? data) => json.encode(data?.toJson());

class UserDetails {
  bool? success;
  Data? data;

  UserDetails({required this.success, required this.data});

  factory UserDetails.fromJson(Map<String?, dynamic>? json) => UserDetails(
    success: json?["success"],
    data: json?["data"] != null ? Data.fromJson(json?["data"]) : null,
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? name;
  String? email;
  String? mobile;
  List<Role> roles;
  String? branch;
  bool? isActive;
  List<String> loginIPs;
  List<dynamic> permissions;
  List<dynamic> delegatedAccess;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isFrozen;
  int? v;
  DateTime? lastLogin;
  String? dataId;

  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.roles,
    required this.branch,
    required this.isActive,
    required this.loginIPs,
    required this.permissions,
    required this.delegatedAccess,
    required this.createdAt,
    required this.updatedAt,
    required this.isFrozen,
    required this.v,
    required this.lastLogin,
    required this.dataId,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    id: json?["_id"],
    name: json?["name"],
    email: json?["email"],
    mobile: json?["mobile"],
    roles: List<Role>.from((json?["roles"] ?? []).map((x) => Role.fromJson(x))),
    branch: json?["branch"],
    isActive: json?["isActive"],
    loginIPs: List<String>.from(
      (json?["loginIPs"] ?? []).map((x) => x.toString()),
    ),
    permissions: List<dynamic>.from((json?["permissions"] ?? []).map((x) => x)),
    delegatedAccess: List<dynamic>.from(
      (json?["delegatedAccess"] ?? []).map((x) => x),
    ),
    createdAt: json?["createdAt"] != null
        ? DateTime.parse(json!["createdAt"])
        : null,
    updatedAt: json?["updatedAt"] != null
        ? DateTime.parse(json!["updatedAt"])
        : null,
    isFrozen: json?["isFrozen"],
    v: json?["__v"],
    lastLogin: json?["lastLogin"] != null
        ? DateTime.parse(json!["lastLogin"])
        : null,
    dataId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
    "branch": branch,
    "isActive": isActive,
    "loginIPs": List<dynamic>.from(loginIPs.map((x) => x)),
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "delegatedAccess": List<dynamic>.from(delegatedAccess.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    'isFrozen': isFrozen,
    "__v": v,
    "lastLogin": lastLogin?.toIso8601String(),
    "id": dataId,
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
  bool? isActive;
  List<dynamic> permissions;
  DateTime? updatedAt;
  String? roleId;

  Role({
    required this.id,
    required this.name,
    required this.v,
    required this.createdAt,
    required this.description,
    required this.inheritedRoles,
    required this.isSuperAdmin,
    required this.isActive,
    required this.permissions,
    required this.updatedAt,
    required this.roleId,
  });

  factory Role.fromJson(Map<String?, dynamic>? json) => Role(
    id: json?["_id"],
    name: json?["name"],
    v: json?["__v"],
    createdAt: json?["createdAt"] != null
        ? DateTime.parse(json!["createdAt"])
        : null,
    description: json?["description"],
    inheritedRoles: List<dynamic>.from(
      (json?["inheritedRoles"] ?? []).map((x) => x),
    ),
    isSuperAdmin: json?["isSuperAdmin"],
    isActive: json?["is_active"],
    permissions: List<dynamic>.from((json?["permissions"] ?? []).map((x) => x)),
    updatedAt: json?["updatedAt"] != null
        ? DateTime.parse(json!["updatedAt"])
        : null,
    roleId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "inheritedRoles": List<dynamic>.from(inheritedRoles.map((x) => x)),
    "isSuperAdmin": isSuperAdmin,
    "is_active": isActive,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": roleId,
  };
}
