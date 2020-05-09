class AppString {
  final String _baseUrl = 'https://min-api.cryptocompare.com';
  AppString._();

  static final AppString _ourInstance = new AppString._();

  static AppString getInstance() {
    return _ourInstance;
  }

  String get baseUrl => _baseUrl;

}
