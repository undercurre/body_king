class Config {
  static const String _baseUrlDev = 'http://192.168.1.2:3000';
  static const String _baseUrlDev1 = 'http://192.168.1.2:3001';
  static const String _baseUrlDev2 = 'http://192.168.1.2:3002';
  static const String _baseUrlDev3 = 'http://192.168.1.2:3003';
  static const String _baseUrlProd = 'https://prod.example.com/api/';

  static String get baseUrl {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev;
  }

  static String get baseUrl1 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev1;
  }

  static String get baseUrl2 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev2;
  }

  static String get baseUrl3 {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev3;
  }
}
