extension StringExtension on String {
  String get capitalizeFirst =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
  String get capitalize =>
      trim().split(' ').map((e) => e.capitalizeFirst).join(' ');
}
