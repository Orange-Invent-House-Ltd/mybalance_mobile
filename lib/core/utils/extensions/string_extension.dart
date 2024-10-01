extension StringExtension on String {
  /// Returns a new string with the first [length] characters of this string.
  String limit(int length) =>
      length < this.length ? substring(0, length) : this;

  /// Returns a new string converted to path.
  String toPath() => '/$this';

  /// Returns a new string with the first character capitalized.
  String capitalize() {
    return substring(0, 1).toUpperCase() + substring(1);
  }

  /// Returns a new string with the first character of each word capitalized.
  String toTitleCase() {
    return split(' ').map((word) => word.capitalize).join(' ');
  }
}
