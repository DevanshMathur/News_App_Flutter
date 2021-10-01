import 'app_exception.dart';

///[ApiResponseWrapper] a custom response wrapper used for processing api data
class ApiResponseWrapper<T> {
  ServerError? _error;
  T? data;

  void setException(ServerError error) {
    _error = error;
  }

  void setData(T data) {
    this.data = data;
  }

  ServerError? get getException => _error;
}
