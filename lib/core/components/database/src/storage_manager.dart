abstract class StorageManager<T> {
  Future<T?> load();
  Future<void> save(T data);
  Future<void> clear();
  Future<void> close();
    Stream<T?>? getStream(); 
}