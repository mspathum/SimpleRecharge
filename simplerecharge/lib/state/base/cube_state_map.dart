import 'package:rxdart/rxdart.dart';

class CubeStateMap<T> {
  late BehaviorSubject<Map<String, T>> _cubeStream;
  final int maxKeys;
  CubeStateMap(Map<String, T> v, this.maxKeys) {
    this._cubeStream = BehaviorSubject<Map<String, T>>.seeded(v);
  }

  Stream<Map<String, T>> get cubeStream$ {
    return _cubeStream.stream;
  }

  Stream<Map<String, T>> get cubeStreamNotNull$ {
    // ignore: unnecessary_null_comparison
    return _cubeStream.stream.where((v) => v != null);
  }

  void clearMap() {
    var v = _cubeStream.value;
    v.clear();
    _cubeStream.add(v);
  }

  void addToMap(String key, T data) {
    var v = _cubeStream.value;
    // ignore: unnecessary_null_comparison
    if (maxKeys != null && v.length > maxKeys) {
      v.clear();
    }

    v[key] = data;

    _cubeStream.add(v);
  }

  void removeItem(String key) {
    var v = _cubeStream.value;
    v.remove(key);
    _cubeStream.add(v);
  }

  void setMap(Map<String, T> n) {
    _cubeStream.add(n);
  }

  T? getValue(String key) {
    if (_cubeStream.value.containsKey(key)) {
      return _cubeStream.value[key];
    }
    return null;
  }

  bool hasKey(String key) {
    return _cubeStream.value.containsKey(key);
  }

  Map<String, T> get getMap => _cubeStream.value;
  List<T> get toList => _cubeStream.value.values.toList();
}
