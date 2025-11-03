// converters.dart
import 'package:json_annotation/json_annotation.dart';

class StandardCodecMapConverter implements JsonConverter<Map<String, dynamic>, Object?> {
  const StandardCodecMapConverter();

  @override
  Map<String, dynamic> fromJson(Object? json) {
    if (json is Map) {
      return json.cast<String, dynamic>().map(
        (key, value) {
          if (value is Map) {
            return MapEntry(key, fromJson(value));
          }
          if (value is List) {
            return MapEntry(key, _convertList(value));
          }
          return MapEntry(key, value);
        },
      );
    }
    return {};
  }

  List<dynamic> _convertList(List list) {
    return list.map((item) {
      if (item is Map) {
        return fromJson(item);
      }
      return item;
    }).toList();
  }

  @override
  Object? toJson(Map<String, dynamic> object) {
    return object;
  }
}
