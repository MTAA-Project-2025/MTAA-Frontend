abstract class NumberFormatingService {
  String formatNumber(int number);
}

class NumberFormatingServiceImpl extends NumberFormatingService {
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
