class DownpaymentModel {
  final String bookingId;
  final int disbursementAmount;
  final int downPaymentExpected;
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
      'isDeviation': isDeviation,
    };
  }

  factory DownpaymentModel.fromJson(Map<String, dynamic> json) {
    return DownpaymentModel(
      bookingId: json['bookingId'] as String,
      disbursementAmount: json['disbursementAmount'] as int,
      downPaymentExpected: json['downPaymentExpected'] as int,
      isDeviation: json['isDeviation'] as bool,
    );
  }
}
