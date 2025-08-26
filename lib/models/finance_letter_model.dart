import 'package:gandhi_tvs/common/app_imports.dart';

class FinanceLetterModel {
  String? financeLetter;

  FinanceLetterModel({this.financeLetter});

  Map<String, dynamic> toJson() {
    return {"financeLetter": financeLetter};
  }

  Future<FormData> toFormData() async {
    final formMap = <String, dynamic>{};

    if (financeLetter != null && await File(financeLetter!).exists()) {
      formMap["financeLetter"] = await MultipartFile.fromFile(financeLetter!);
    } else {
      throw Exception(
        "Finance letter file does not exist at path: $financeLetter",
      );
    }

    return FormData.fromMap(formMap);
  }

  factory FinanceLetterModel.fromJson(Map<String, dynamic> json) {
    return FinanceLetterModel(financeLetter: json["financeLetter"] ?? '');
  }
}
