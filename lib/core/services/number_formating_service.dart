/// Defines a method for formatting numbers.
abstract class NumberFormatingService {
  /// Formats a number into a compact string representation.
  String formatNumber(int number);
}

/// Implements number formatting with compact units (k, M, B).
class NumberFormatingServiceImpl extends NumberFormatingService {
  /// Formats a number into a string, using 'k' for thousands, 'M' for millions, and 'B' for billions.
  @override
  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1_000_000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else if (number < 1_000_000_000) {
      return '${(number / 1_000_000).toStringAsFixed(1)}M';
    }
    return '${(number / 1_000_000_000).toStringAsFixed(1)}B';
  }
}
