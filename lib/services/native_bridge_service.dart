import 'package:flutter/services.dart';

class NativeBridgeService {
  static const MethodChannel _channel = MethodChannel('autoclickmobileapp/native');

  Future<bool> checkAccessibility() async {
    try {
      final result = await _channel.invokeMethod<bool>('checkAccessibility');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> checkOverlayPermission() async {
    try {
      final result = await _channel.invokeMethod<bool>('checkOverlayPermission');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> startClicker() async {
    try {
      final result = await _channel.invokeMethod<bool>('startClicker');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> stopClicker() async {
    try {
      final result = await _channel.invokeMethod<bool>('stopClicker');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> pauseClicker() async {
    try {
      final result = await _channel.invokeMethod<bool>('pauseClicker');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> resumeClicker() async {
    try {
      final result = await _channel.invokeMethod<bool>('resumeClicker');
      return result ?? false;
    } on PlatformException {
      return false;
    }
  }
}
