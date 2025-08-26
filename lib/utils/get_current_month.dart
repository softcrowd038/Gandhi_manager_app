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
    'December'
  ];
  return '${monthNames[now.month - 1]} ${now.year}';
}
