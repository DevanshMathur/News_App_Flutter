import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/api_lib/service_manager.dart';
import 'package:news_headlines/src/app/block/theme/theme_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_state.dart';
import 'package:news_headlines/src/app_utils/api_constants.dart';
import 'package:news_headlines/src/app_utils/app_preference.dart';
import 'package:news_headlines/src/navigation/routes.dart';
import 'package:news_headlines/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HashMap<String, String>? headerHashMap = HashMap();
  headerHashMap[NewsApiConstants.kApiBaseUrlHeader] = NewsApiConstants.kBaseUrl;
  headerHashMap[NewsApiConstants.kApiKeyHeader] = NewsApiConstants.kApiKey;
  ServiceManager.init(
      baseUrl: NewsApiConstants.kBaseUrl, defaultHeaders: headerHashMap);
  await AppPreference.getAppPrefInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            routes: Routes.routes,
            initialRoute: Routes.homeScreen,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
