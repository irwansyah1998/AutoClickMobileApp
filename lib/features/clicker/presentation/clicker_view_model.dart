import 'dart:async';

import 'package:autoclickmobileapp/data/models/click_configuration.dart';
import 'package:autoclickmobileapp/data/models/click_point.dart';
import 'package:autoclickmobileapp/features/clicker/domain/clicker_status.dart';

class ClickerViewModel {
  ClickerStatus status = ClickerStatus.idle;
  int clickCount = 0;
  int elapsedSeconds = 0;
  int currentPointIndex = 0;
  DateTime? startedAt;
  Timer? _elapsedTimer;

  final ClickConfiguration configuration;

  ClickerViewModel({
    required this.configuration,
  }) {
    currentPointIndex = configuration.points.indexWhere((point) => point.enabled);
    if (currentPointIndex < 0) currentPointIndex = 0;
  }

  void start() {
    if (status == ClickerStatus.running) {
      return;
    }

    status = ClickerStatus.running;
    startedAt = DateTime.now();
    _elapsedTimer?.cancel();
    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      elapsedSeconds += 1;
    });
  }

  void pause() {
    if (status == ClickerStatus.running) {
      status = ClickerStatus.paused;
    }
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  void stop() {
    status = ClickerStatus.stopped;
    clickCount = 0;
    elapsedSeconds = 0;
    currentPointIndex = 0;
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }

  String statusLabel() {
    switch (status) {
      case ClickerStatus.idle:
        return 'Ready';
      case ClickerStatus.running:
        return 'Running';
      case ClickerStatus.paused:
        return 'Paused';
      case ClickerStatus.stopped:
        return 'Stopped';
      case ClickerStatus.error:
        return 'Error';
    }
  }

  String formatElapsed() {
    final minutes = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  List<ClickPoint> enabledPoints() =>
      configuration.points.where((point) => point.enabled).toList();

  void dispose() {
    _elapsedTimer?.cancel();
    _elapsedTimer = null;
  }
}
