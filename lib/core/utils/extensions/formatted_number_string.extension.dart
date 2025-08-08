/// * convert the long number value to the formatted string [1,000,000]
extension FormattedNumberString on num {
  String toFormattedString({
    precision = 2,
  }) {
    // Convert number to string with commas
    final parts = toStringAsFixed(precision).split('.');
    final wholePart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );

    // If there's a decimal part, append it
    if (parts.length > 1) {
      return '$wholePart${parts[1] == "00" ? "" : ".${parts[1]}"}';
    }

    return wholePart;
  }
}
