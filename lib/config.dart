class Config {
  static const String _baseUrlDev = 'http://81.71.85.68:3000';
  static const String _baseUrlDev1 = 'http://81.71.85.68:3001';
  static const String _baseUrlDev2 = 'http://81.71.85.68:3002';
  static const String _baseUrlDev3 = 'http://81.71.85.68:3003';
  static const String _baseUrlProd = 'http://81.71.85.68:3000';
  static const String _baseUrlProd1 = 'http://81.71.85.68:3001';
  static const String _baseUrlProd2 = 'http://81.71.85.68:3002';
  static const String _baseUrlProd3 = 'http://81.71.85.68:3003';

  static String get baseUrl {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev;
  }

  static String get baseUrl1 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd1 : _baseUrlDev1;
  }

  static String get baseUrl2 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd2 : _baseUrlDev2;
  }

  static String get baseUrl3 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd3 : _baseUrlDev3;
  }
}
