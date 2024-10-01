extension MapIndexed<T> on List<T> {
  List<R> mapIndexed<R>(R Function(int index, T item) f) {
    var i = 0;
    return map((e) => f(i++, e)).toList();
  }
}
