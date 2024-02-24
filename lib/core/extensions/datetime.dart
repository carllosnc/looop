import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDatetime() {
    return DateFormat('dd/MM/yyyy | EEE - HH:mm').format(this).toString();
  }

  String formatDate() {
    return DateFormat('dd/MM/yyyy').format(this).toString();
  }

  String toCompare() {
    return DateFormat('dd/MM/yyyy').format(this).toString();
  }
}
