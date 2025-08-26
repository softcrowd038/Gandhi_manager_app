import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:intl/intl.dart';

class UsefulFunctions {
  String formatDateToYyyyMmDd(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrlString(uri.toString());
  }

  void doWhatsAppMessage(
    BuildContext context,
    String phone,
    String message,
  ) async {
    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl = 'https://wa.me/$phone?text=$encodedMessage';

    await launchUrl(Uri.parse(whatsappUrl));
  }

  void sendEmail(
    BuildContext context,
    String email,
    String subject,
    String message,
  ) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': subject, 'body': message},
    );

    await launchUrl(emailUri);
  }

  String getCurrentMonthAndYear() {
    DateTime now = DateTime.now();
    List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${monthNames[now.month - 1]} ${now.year}';
  }
}
