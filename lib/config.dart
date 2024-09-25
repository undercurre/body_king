class Config {
  static const String _baseUrlDev = 'http://192.168.166.136:3000';
  static const String _baseUrlProd = 'https://prod.example.com/api/';

  static String get baseUrl {
    const bool isProduction = bool.fromEnvironment('dart.vm.product');
    return isProduction ? _baseUrlProd : _baseUrlDev;
  }
}
