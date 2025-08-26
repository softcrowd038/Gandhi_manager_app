import 'package:gandhi_tvs/common/app_imports.dart';

QuotationsByDay quotationsByDayFromJson(String str) =>
    QuotationsByDay.fromJson(json.decode(str));

String quotationsByDayToJson(QuotationsByDay data) =>
    json.encode(data.toJson());

class QuotationsByDay {
  String? status;
  Data? data;

  QuotationsByDay({required this.status, required this.data});

  factory QuotationsByDay.fromJson(Map<String?, dynamic>? json) =>
      QuotationsByDay(
        status: json?["status"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  int? count;

  Data({required this.count});

  factory Data.fromJson(Map<String?, dynamic>? json) =>
      Data(count: json?["count"]);

  Map<String?, dynamic>? toJson() => {"count": count};
}
