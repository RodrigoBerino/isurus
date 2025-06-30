class DBHelper {
  static final Map<String, dynamic> _storage = {};

  static void save(String key, dynamic value) {
    _storage[key] = value;
  }

  static dynamic load(String key) {
    return _storage[key];
  }

  static void delete(String key) {
    _storage.remove(key);
  }
}
