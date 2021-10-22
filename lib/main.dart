import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:news_headlines/src/api_lib/service_manager.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';
import 'package:news_headlines/src/app_utils/app_preference.dart';

import 'base_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HashMap<String, String>? headerHashMap = HashMap();
  headerHashMap[NewsApiConstants.kApiKeyHeader] = NewsApiConstants.kApiKey;
  ServiceManager.init( baseUrl: NewsApiConstants.kBaseUrl, defaultHeaders: headerHashMap);

  await AppPreference.getAppPrefInstance();

  runApp(const BaseApp());
}
