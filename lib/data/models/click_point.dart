import 'package:autoclickmobileapp/core/utils/validators.dart';

class ClickPoint {
  final int x;
  final int y;
  final bool enabled;
  final int delayMs;
  final String id;
  final String label;

  ClickPoint({
    required this.x,
    required this.y,
    this.enabled = true,
    this.delayMs = 0,
    String? id,
    String? label,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        label = label ?? 'Point' {
    if (!AppValidators.isValidCoordinate(x)) {
      throw ArgumentError.value(x, 'x', 'X coordinate must be >= 0');
    }
    if (!AppValidators.isValidCoordinate(y)) {
      throw ArgumentError.value(y, 'y', 'Y coordinate must be >= 0');
    }
    if (!AppValidators.isValidDelay(delayMs)) {
      throw ArgumentError.value(
        delayMs,
        'delayMs',
        'Delay must be between 0 and 60000 ms',
      );
    }
  }

  ClickPoint copyWith({
    int? x,
    int? y,
    bool? enabled,
    int? delayMs,
    String? id,
    String? label,
  }) {
    return ClickPoint(
      x: x ?? this.x,
      y: y ?? this.y,
      enabled: enabled ?? this.enabled,
      delayMs: delayMs ?? this.delayMs,
      id: id ?? this.id,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'x': x,
        'y': y,
        'enabled': enabled,
        'delayMs': delayMs,
      };

  factory ClickPoint.fromJson(Map<String, dynamic> json) {
    return ClickPoint(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? 'Point',
      x: (json['x'] as num?)?.toInt() ?? 0,
      y: (json['y'] as num?)?.toInt() ?? 0,
      enabled: json['enabled'] as bool? ?? true,
      delayMs: (json['delayMs'] as num?)?.toInt() ?? 0,
    );
  }
}
