extension StringExtension on String {
  String get capitalizeFirst => isNotEmpty && [0].isNotEmpty
      ? '${this[0].toUpperCase()}${substring(1)}'
      : '';
  String get capitalize =>
      trim().split(' ').map((e) => e.capitalizeFirst).join(' ');
}
