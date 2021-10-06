import 'package:dio/dio.dart';

///[ServerError] is custom exception specific to the application
class ServerError implements Exception {
  late int _errorCode;
  late String _errorMessageKey = "";
  DioError? _error;

  ServerError() {
    _errorCode = kApiUnknownErrorCode;
    _errorMessageKey = kApiUnknownError;
  }

  ServerError.withError(DioError error) {
    _handleError(error);
    _error = error;
  }

  /// Returns either some app based code or Api response error code
  int getErrorCode() => _errorCode;

  /// Custom messages to take actions based on it
  String getErrorMessage() => _errorMessageKey;

  /// Provides DioError data to identify real cause during debugging
  DioError? getDioError() => _error;

  static const int kApiCanceledCode = 1;
  static const int kApiConnectionTimeoutCode = 2;
  static const int kApiDefaultCode = 3;
  static const int kApiReceiveTimeoutCode = 4;
  static const int kApiSendTimeoutCode = 5;
  static const int kApiUnknownErrorCode = 0;

  static const String kApiCanceled = 'API_CANCELED';
  static const String kApiConnectionTimeout = 'CONNECT_TIMEOUT';
  static const String kApiDefault = 'DEFAULT';
  static const String kApiReceiveTimeout = 'RECEIVE_TIMEOUT';
  static const String kApiSendTimeout = 'SEND_TIMEOUT';
  static const String kApiUnknownError = 'UNKNOWN_ERROR';
  static const String kApiResponseError = 'RESPONSE_ERROR';

  void _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        _errorCode = kApiCanceledCode;
        _errorMessageKey = kApiCanceled;
        break;
      case DioErrorType.connectTimeout:
        _errorCode = kApiConnectionTimeoutCode;
        _errorMessageKey = kApiConnectionTimeout;
        break;
      case DioErrorType.other:
        _errorCode = kApiDefaultCode;
        _errorMessageKey = kApiDefault;
        break;
      case DioErrorType.receiveTimeout:
        _errorCode = kApiReceiveTimeoutCode;
        _errorMessageKey = kApiReceiveTimeout;
        break;
      case DioErrorType.response:
        _errorCode = error.response?.statusCode ?? 0;
        _errorMessageKey = kApiResponseError;
        break;
      case DioErrorType.sendTimeout:
        _errorCode = kApiSendTimeoutCode;
        _errorMessageKey = kApiSendTimeout;
        break;
      default:
        _errorCode = kApiUnknownErrorCode;
        _errorMessageKey = kApiUnknownError;
    }
  }
}
