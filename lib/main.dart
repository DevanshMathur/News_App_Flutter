import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:news_headlines/src/api_lib/service_manager.dart';
import 'package:news_headlines/src/app/ui/home/news_home.dart';
import 'package:news_headlines/src/constants/api_constants.dart';
import 'package:news_headlines/theme/app_theme.dart';

void main() {

  HashMap<String,String>? headerHashMap = HashMap();
  headerHashMap[NewsApiConstants.kApiBaseUrlHeader] = NewsApiConstants.kBaseUrl;
  headerHashMap[NewsApiConstants.kApiKeyHeader] = NewsApiConstants.kApiKey;
  ServiceManager.init(baseUrl: NewsApiConstants.kBaseUrl,
      defaultHeaders: headerHashMap);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const NewsHome()
    );
  }
}
