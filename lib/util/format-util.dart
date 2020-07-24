class FormatUtil {
  static String formatPrice(double price) {
//    return price.toStringAsFixed(price.truncateToDouble() == price ? 0 : 2);
    return price.toStringAsFixed(2);
  }
}
