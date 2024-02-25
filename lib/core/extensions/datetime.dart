import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime() {
    return DateFormat('dd · MM · yyyy').format(this).toString();
  }

  String formatToBadge() {
    return DateFormat('dd • MMM').format(this).toString();
  }

  String toCompare() {
    return DateFormat('dd/MM/yyyy').format(this).toString();
  }
}
