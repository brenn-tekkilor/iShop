abstract class EnumParser {
  static T? fromString<T>(Iterable<T> values, String value) =>
      values.firstWhere((e) =>
          "${e.toString().substring(e.toString().indexOf('.') + 1)}"
              .toString()
              .toLowerCase() ==
          value.toLowerCase());

  static String stringValue<T>(T value) =>
      value.toString().replaceFirst(RegExp(r"[A-Za-z0-9-_']+?\."), '');
}
