import 'dart:async';

/// 通用操作接口
abstract class StorageOperator {
  Future<void> put(String key, dynamic value);

  Future<String?> get(String key);

  Future<void> putBool(String key, bool value);

  Future<bool?> getBool(String key);

  Future<void> putString(String key, String value);

  Future<String?> getString(String key);

  Future<void> putInt(String key, int value);

  Future<int?> getInt(String key);

  Future<void> putDouble(String key, double value);

  Future<double?> getDouble(String key);

  Future<void> putLong(String key, int value);

  Future<int?> getLong(String key);

  Future<void> clear();
}
