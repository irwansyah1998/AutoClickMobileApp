import 'package:autoclickmobileapp/core/utils/validators.dart';
import 'package:autoclickmobileapp/data/models/click_point.dart';

enum LoopMode { unlimited, finite }

class ClickConfiguration {
  final int intervalMs;
  final int pointDelayMs;
  final LoopMode loopMode;
  final int loopCount;
  final List<ClickPoint> points;
  final bool infiniteLoop;
  final bool useCustomDelay;

  ClickConfiguration({
    required this.intervalMs,
    required this.pointDelayMs,
    required this.loopMode,
    this.loopCount = 1,
    this.points = const [],
    this.infiniteLoop = false,
    this.useCustomDelay = false,
  }) {
    if (!AppValidators.isValidInterval(intervalMs)) {
      throw ArgumentError.value(intervalMs, 'intervalMs', 'Interval must be between 1 and 60000 ms');
    }
    if (!AppValidators.isValidDelay(pointDelayMs)) {
      throw ArgumentError.value(pointDelayMs, 'pointDelayMs', 'Delay must be between 0 and 60000 ms');
    }
    if (points.isEmpty) {
      throw ArgumentError.value(points, 'points', 'At least one click point is required');
    }
    if (loopMode == LoopMode.finite && !infiniteLoop && !AppValidators.isValidLoopCount(loopCount)) {
      throw ArgumentError.value(loopCount, 'loopCount', 'Loop count must be between 1 and 100000');
    }
  }

  bool get isValid {
    if (!AppValidators.isValidInterval(intervalMs)) return false;
    if (!AppValidators.isValidDelay(pointDelayMs)) return false;
    if (points.isEmpty) return false;
    if (loopMode == LoopMode.finite && !infiniteLoop) {
      return AppValidators.isValidLoopCount(loopCount);
    }
    return true;
  }

  int get remainingLoops {
    if (infiniteLoop || loopMode == LoopMode.unlimited) return -1;
    return loopCount;
  }

  ClickConfiguration copyWith({
    int? intervalMs,
    int? pointDelayMs,
    LoopMode? loopMode,
    int? loopCount,
    List<ClickPoint>? points,
    bool? infiniteLoop,
    bool? useCustomDelay,
  }) {
    return ClickConfiguration(
      intervalMs: intervalMs ?? this.intervalMs,
      pointDelayMs: pointDelayMs ?? this.pointDelayMs,
      loopMode: loopMode ?? this.loopMode,
      loopCount: loopCount ?? this.loopCount,
      points: points ?? this.points,
      infiniteLoop: infiniteLoop ?? this.infiniteLoop,
      useCustomDelay: useCustomDelay ?? this.useCustomDelay,
    );
  }

  Map<String, dynamic> toJson() => {
        'intervalMs': intervalMs,
        'pointDelayMs': pointDelayMs,
        'loopMode': loopMode.name,
        'loopCount': loopCount,
        'infiniteLoop': infiniteLoop,
        'useCustomDelay': useCustomDelay,
        'points': points.map((point) => point.toJson()).toList(),
      };

  factory ClickConfiguration.fromJson(Map<String, dynamic> json) {
    final items = (json['points'] as List<dynamic>? ?? <dynamic>[])
        .map((e) => ClickPoint.fromJson(Map<String, dynamic>.from(e as Map)))
        .toList();

    return ClickConfiguration(
      intervalMs: (json['intervalMs'] as num?)?.toInt() ?? 100,
      pointDelayMs: (json['pointDelayMs'] as num?)?.toInt() ?? 0,
      loopMode: LoopMode.values.firstWhere(
        (mode) => mode.name == (json['loopMode'] as String? ?? 'unlimited'),
        orElse: () => LoopMode.unlimited,
      ),
      loopCount: (json['loopCount'] as num?)?.toInt() ?? 1,
      points: items,
      infiniteLoop: json['infiniteLoop'] as bool? ?? false,
      useCustomDelay: json['useCustomDelay'] as bool? ?? false,
    );
  }
}
