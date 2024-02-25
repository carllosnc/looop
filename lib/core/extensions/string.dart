extension StringExtension on String {
  String formatHour() {
    final RegExp regExp = RegExp(r'^([01]?[0-9]|2[0-3]):[0-5][0-9]$');

    if (!regExp.hasMatch(this)) {
      throw const FormatException('Invalid hour format');
    }

    final hour = int.parse(split(':')[0]);

    if (hour >= 0 && hour < 12) {
      return 'Morning: $this';
    } else if (hour >= 12 && hour < 18) {
      return 'Afternoon: $this';
    } else {
      return 'Evening: $this';
    }
  }

  String formatName() {
    return split(' ')[0];
  }

  String get inCaps => '${this[0].toUpperCase()}${substring(1)}';
}
