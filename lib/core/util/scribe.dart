class Scribe {
  static String condense({String value, int max, String trailing}) {
    var result = max > 0 ? value ?? '' : '';
    trailing = trailing ?? '';
    if (result.isNotEmpty && max > 0 && result.length > max) {
      max = max - trailing.length;
      result = result.substring(0, max - 1) + trailing;
    }
    return result;
  }

  static bool isNotNullOrEmpty(String value) {
    return (value != null && value.isNotEmpty) ? true : false;
  }
}
