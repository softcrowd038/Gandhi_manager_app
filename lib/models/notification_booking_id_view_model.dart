import 'package:gandhi_tvs/common/app_imports.dart';

NotificationBookingIdViewdModel notificationBookingIdViewdModelFromJson(
  String str,
) => NotificationBookingIdViewdModel.fromJson(json.decode(str));

String notificationBookingIdViewdModelToJson(
  NotificationBookingIdViewdModel data,
) => json.encode(data.toJson());

class NotificationBookingIdViewdModel {
  List<String> bookingId;

  NotificationBookingIdViewdModel({required this.bookingId});

  factory NotificationBookingIdViewdModel.fromJson(Map<String, dynamic> json) =>
      NotificationBookingIdViewdModel(
        bookingId: List<String>.from(json["bookingId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "bookingId": List<dynamic>.from(bookingId.map((x) => x)),
  };
}
