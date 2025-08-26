import 'package:gandhi_tvs/common/app_imports.dart';

QuotationsByMonth quotationsByMonthFromJson(String str) =>
    QuotationsByMonth.fromJson(json.decode(str));

String quotationsByMonthToJson(QuotationsByMonth data) =>
    json.encode(data.toJson());

class QuotationsByMonth {
  String? status;
  Data? data;

  QuotationsByMonth({required this.status, required this.data});

  factory QuotationsByMonth.fromJson(Map<String?, dynamic>? json) =>
      QuotationsByMonth(
        status: json?["status"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String, dynamic> toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  int? count;

  Data({required this.count});

  factory Data.fromJson(Map<String?, dynamic>? json) =>
      Data(count: json?["count"]);

  Map<String?, dynamic>? toJson() => {"count": count};
}
