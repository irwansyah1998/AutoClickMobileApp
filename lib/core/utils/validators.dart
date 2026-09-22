class AppValidators {
  static bool isPositiveInteger(int value) => value > 0;

  static bool isNonNegativeInteger(int value) => value >= 0;

  static bool isValidCoordinate(int value) => value >= 0;

  static bool isValidInterval(int value) =>
      value >= 1 && value <= 60 * 1000;

  static bool isValidDelay(int value) =>
      value >= 0 && value <= 60 * 1000;

  static bool isValidLoopCount(int value) =>
      value >= 1 && value <= 100000;
}
