import 'package:flutter_test/flutter_test.dart';
import 'package:autoclickmobileapp/data/models/click_configuration.dart';
import 'package:autoclickmobileapp/data/models/click_point.dart';
import 'package:autoclickmobileapp/core/utils/validators.dart';

void main() {
  group('ClickPoint', () {
    test('creates a valid click point', () {
      final point = ClickPoint(x: 500, y: 800, enabled: true, delayMs: 50);

      expect(point.x, equals(500));
      expect(point.y, equals(800));
      expect(point.enabled, isTrue);
      expect(point.delayMs, equals(50));
    });

    test('rejects invalid coordinates', () {
      expect(() => ClickPoint(x: -1, y: 100, enabled: true), throwsArgumentError);
      expect(() => ClickPoint(x: 100, y: -1, enabled: true), throwsArgumentError);
    });
  });

  group('ClickConfiguration', () {
    test('validates loop count and interval', () {
      final config = ClickConfiguration(
        intervalMs: 100,
        pointDelayMs: 25,
        loopMode: LoopMode.unlimited,
        loopCount: 10,
        points: [
          ClickPoint(x: 100, y: 100, enabled: true),
          ClickPoint(x: 200, y: 200, enabled: true),
        ],
      );

      expect(config.isValid, isTrue);
      expect(config.remainingLoops, equals(-1));
    });

    test('rejects invalid interval values', () {
      expect(
        () => ClickConfiguration(
          intervalMs: 0,
          pointDelayMs: 25,
          loopMode: LoopMode.unlimited,
          points: [ClickPoint(x: 100, y: 100, enabled: true)],
        ),
        throwsArgumentError,
      );
    });
  });

  group('Validators', () {
    test('returns true for valid positive durations', () {
      expect(AppValidators.isPositiveInteger(100), isTrue);
      expect(AppValidators.isPositiveInteger(1), isTrue);
    });

    test('returns false for invalid values', () {
      expect(AppValidators.isPositiveInteger(0), isFalse);
      expect(AppValidators.isPositiveInteger(-5), isFalse);
    });
  });
}
