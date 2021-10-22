import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/search/search_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_state.dart';
import 'package:news_headlines/src/navigation/routes.dart';
import 'package:news_headlines/theme/app_theme.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
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
