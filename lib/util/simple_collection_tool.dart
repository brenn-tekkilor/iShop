abstract class IterableUtil {
  static bool isEmpty(Iterable value) => (value.isNotEmpty) ? false : true;
  static bool isNotEmpty(Iterable value) => !isEmpty(value);
}
