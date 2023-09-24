import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

class DateAndTimeFormat {

  Future<DateTime> getDateFromNTP() async {
    return await NTP.now();
  }

  static Future<String> getCurrentDate() async {
    final DateTime currentDate = await DateAndTimeFormat().getDateFromNTP();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    return formatter.format(currentDate);
  }

  static Future<int> getCurrentHour() async {
    final DateTime currentDate = await DateAndTimeFormat().getDateFromNTP();

    return currentDate.hour;
  }

  static int getHourFromDate(String date) {
    return DateTime.parse(date).hour;
  }

  static String addDaysToDate(String date, int days) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime dateFormat = formatter.parse(date);
    final DateTime fechaSumada = dateFormat.add(Duration(days: days));

    return formatter.format(fechaSumada);
  }

  static String formatDateTime(String date, String format) {
    final DateFormat formatter = DateFormat(format);

    return formatter.format(DateTime.parse(date));
  }

}