class AppException implements Exception {
  static const kNotEnoughBalance = 900;
  static const kHaveToAgree = 901;
  static const kFillNecessaryData = 902;
  static const kWarningPhoneNumberWithoutZero = 903;
  static const kUnknownError = 904;
  static const kWarningPhoneNotTrue = 905;
  static const kWarningCodeNotTrue = 906;

  final int? code;
  String message;

  AppException({this.code, required this.message});

  @override
  String toString() {
    return "AppException Code: $code, message: $message";
  }
}
