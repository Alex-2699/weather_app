import 'package:intl/intl.dart';

class DateAndTimeFormat {

  static String getDate() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static String addDaysToDate(String date, int days) {
    final formatter = DateFormat('yyyy-MM-dd');
    final dateFormat = formatter.parse(date);
    final fechaSumada = dateFormat.add(Duration(days: days));
    return formatter.format(fechaSumada);
  }

  static String formatDateTime(String date, String format) {
    final formatter = DateFormat(format);
    return formatter.format(DateTime.parse(date));
  }

}