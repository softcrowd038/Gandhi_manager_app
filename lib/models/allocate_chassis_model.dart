import 'package:gandhi_tvs/common/app_imports.dart';

class ChassisAllocationModel {
  final String? id;
  String? reason;
  final String chassisNumber;
  final bool hasClaim;
  final String? hasDeviation;
  final double? priceClaim;
  final String? description;
  final List<XFile> documents;

  ChassisAllocationModel({
    this.id,
    this.reason,
    required this.chassisNumber,
    this.hasDeviation,
    this.hasClaim = false,
    this.priceClaim,
    this.description,
    this.documents = const [],
  });

  Future<Map<String, dynamic>> toFormData() async {
    final formData = <String, dynamic>{
      'chassisNumber': chassisNumber,
      'reason': reason,
      'hasClaim': hasClaim.toString(),
      'is_deviation': hasDeviation,
      if (priceClaim != null) 'priceClaim': priceClaim!.toString(),
      if (description != null && description!.isNotEmpty)
        'description': description,
    };

    for (int i = 0; i < documents.length; i++) {
      formData['documents[$i]'] = await MultipartFile.fromFile(
        documents[i].path,
        filename: documents[i].path.split('/').last,
      );
    }

    return formData;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reason': reason,
      'chassisNumber': chassisNumber,
      'hasClaim': hasClaim,
      'is_deviation': hasDeviation,
      'priceClaim': priceClaim,
      'description': description,
      'documents': documents.map((file) => file.path).toList(),
    };
  }

  ChassisAllocationModel copyWith({
    String? id,
    String? reason,
    String? chassisNumber,
    bool? hasClaim,
    String? hasDeviation,
    double? priceClaim,
    String? description,
    List<XFile>? documents,
  }) {
    return ChassisAllocationModel(
      id: id ?? this.id,
      reason: reason ?? this.reason,
      chassisNumber: chassisNumber ?? this.chassisNumber,
      hasClaim: hasClaim ?? this.hasClaim,
      hasDeviation: hasDeviation ?? this.hasDeviation,
      priceClaim: priceClaim ?? this.priceClaim,
      description: description ?? this.description,
      documents: documents ?? this.documents,
    );
  }

  bool validate() {
    return chassisNumber.isNotEmpty &&
        reason!.isNotEmpty; // Added reason validation
  }

  List<String> getValidationErrors() {
    final errors = <String>[];

    if (chassisNumber.isEmpty) {
      errors.add('Chassis number is required');
    }

    if (reason!.isEmpty) {
      // Added reason validation
      errors.add('Reason is required');
    }

    if (hasClaim && (priceClaim == null || priceClaim! <= 0)) {
      errors.add('Valid price claim is required when hasClaim is true');
    }

    return errors;
  }
}

class ChassisChangeResponse {
  final String message;
  final bool success;
  final String? newChassisNumber;
  final DateTime? updatedAt;

  ChassisChangeResponse({
    required this.message,
    required this.success,
    this.newChassisNumber,
    this.updatedAt,
  });

  factory ChassisChangeResponse.fromJson(Map<String, dynamic> json) {
    return ChassisChangeResponse(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      newChassisNumber: json['newChassisNumber'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}
