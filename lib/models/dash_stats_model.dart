import 'package:gandhi_tvs/common/app_imports.dart';

DashStatsModel dashStatsModelFromJson(String str) =>
    DashStatsModel.fromJson(json.decode(str));

String dashStatsModelToJson(DashStatsModel data) => json.encode(data.toJson());

class DashStatsModel {
  bool success;
  Data data;

  DashStatsModel({required this.success, required this.data});

  factory DashStatsModel.fromJson(Map<String, dynamic> json) => DashStatsModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"success": success, "data": data.toJson()};
}

class Data {
  Counts counts;
  PendingDocuments pendingDocuments;

  Data({required this.counts, required this.pendingDocuments});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    counts: Counts.fromJson(json["counts"]),
    pendingDocuments: PendingDocuments.fromJson(json["pendingDocuments"]),
  );

  Map<String, dynamic> toJson() => {
    "counts": counts.toJson(),
    "pendingDocuments": pendingDocuments.toJson(),
  };
}

class Counts {
  int today;
  int thisWeek;
  int thisMonth;
  int? total;

  Counts({
    required this.today,
    required this.thisWeek,
    required this.thisMonth,
    this.total,
  });

  factory Counts.fromJson(Map<String, dynamic> json) => Counts(
    today: json["today"],
    thisWeek: json["thisWeek"],
    thisMonth: json["thisMonth"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "today": today,
    "thisWeek": thisWeek,
    "thisMonth": thisMonth,
    "total": total,
  };
}

class PendingDocuments {
  Counts kyc;
  Counts financeLetter;

  PendingDocuments({required this.kyc, required this.financeLetter});

  factory PendingDocuments.fromJson(Map<String, dynamic> json) =>
      PendingDocuments(
        kyc: Counts.fromJson(json["kyc"]),
        financeLetter: Counts.fromJson(json["financeLetter"]),
      );

  Map<String, dynamic> toJson() => {
    "kyc": kyc.toJson(),
    "financeLetter": financeLetter.toJson(),
  };
}
