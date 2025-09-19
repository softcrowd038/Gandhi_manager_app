class DownpaymentModel {
  final String bookingId;
  final double disbursementAmount;
  final double downPaymentExpected;
  final bool isDeviation;

  DownpaymentModel({
    required this.bookingId,
    required this.disbursementAmount,
    required this.downPaymentExpected,
    required this.isDeviation,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'disbursementAmount': disbursementAmount,
      'downPaymentExpected': downPaymentExpected,
      'is_deviation': isDeviation,
    };
  }

  factory DownpaymentModel.fromJson(Map<String, dynamic> json) {
    return DownpaymentModel(
      bookingId: json['bookingId'] as String,
      disbursementAmount: json['disbursementAmount'] as double,
      downPaymentExpected: json['downPaymentExpected'] as double,
      isDeviation: json['is_deviation'] as bool,
    );
  }
}
