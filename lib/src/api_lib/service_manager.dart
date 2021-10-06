import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// [ServiceManager] handles the basic creation of api clients based on dio
class ServiceManager {
  static ServiceManager? _serviceManager;

  // App BaseUrl
  String? _baseUrl;

  //Is Debug Mode
  late bool _isDebug;

  final HashMap<String, String> _defaultHeaders = HashMap();

  /// This method should be initialised in main.dart file with required params
  /// [baseUrl] can be optional, but is recommended to be shared at the very start
  static void init(
      {@required String? baseUrl,
      bool isDebug = false,
      HashMap<String, String>? defaultHeaders}) {
    _serviceManager ??= ServiceManager._instance(
        baseUrl: baseUrl, isDebug: isDebug, defaultHeaders: defaultHeaders);
  }

  ServiceManager._instance(
      {@required String? baseUrl,
      bool isDebug = false,
      HashMap<String, String>? defaultHeaders}) {
    _baseUrl = baseUrl;
    _isDebug = isDebug;
    if (defaultHeaders != null && defaultHeaders.isNotEmpty) {
      _defaultHeaders.addAll(defaultHeaders);
    }
  }

  /// Method to get Singleton instance of the class
  static ServiceManager get() {
    if (_serviceManager == null) {
      throw Exception("Method not initialised");
    }
    return _serviceManager!;
  }

  /// this method creates dio client with basic setting needed for each instance
  Dio getDioClient({
    String? baseUrl,
    HashMap<String, String>? moreHeaders,
  }) {
    final dio = Dio();

    HashMap<String, String> hashMap = HashMap();
    hashMap['Content-Type'] = 'application/json; charset=utf-8';
    hashMap['Accept'] = 'application/json; charset=utf-8';

    dio
      ..options.baseUrl = baseUrl ?? _baseUrl ?? ''
      ..options.headers.addAll(hashMap);
    if (baseUrl != null && baseUrl.trim().isNotEmpty) {
      dio.options.baseUrl = baseUrl.trim();
    }
    if (_defaultHeaders.isNotEmpty) {
      dio.options.headers.addAll(_defaultHeaders);
    }
    if (moreHeaders != null && moreHeaders.isNotEmpty) {
      dio.options.headers.addAll(moreHeaders);
    }

    if (_isDebug) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }
    return dio;
  }
}
