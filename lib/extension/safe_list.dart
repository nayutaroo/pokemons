extension SafeList<T> on List<T> {
  T? safeGet(int index) {
    return (index < 0 || index >= length) ? null : this[index];
  }
}