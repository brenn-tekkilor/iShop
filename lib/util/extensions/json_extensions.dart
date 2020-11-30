/// json extensions
extension JsonExtensions on Map<String, dynamic> {
  /// value of key
  dynamic getValue(String key) => containsKey(key) ? this[key] : null;

  /// parses json map
  dynamic traverse({required List<String> keys}) {
    var m = this;
    var i = 0;
    while (keys[i] != keys.last && m.isNotEmpty) {
      final e = keys[i];
      final dynamic x = m.getValue(e);
      final y = x is Map<String, dynamic> ? x : null;
      m = y ?? <String, dynamic>{};
      i++;
    }
    return m.getValue(keys[i]);
  }

  /// returns a double at the specified key at the current depth or nan
  double getDouble(String key) {
    final dynamic x = getValue(key);
    return x is double ? x : double.nan;
  }

  /// returns latitude double value or nan
  double get latitude => getDouble('latitude');

  /// return longitude double value or nan
  double get longitude => getDouble('longitude');
}
