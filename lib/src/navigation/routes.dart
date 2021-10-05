import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/ui/home/news_home.dart';
import 'package:news_headlines/src/app/ui/search/search_screen.dart';
import 'package:news_headlines/src/app/ui/widgets/news_details.dart';


class Routes {
  Routes._();

  static const String homeScreen = '/';
  static const String newsSearch = '/search';
  static const String newsDetails = '/details';


  static final routes = <String, WidgetBuilder>{
    homeScreen: (context) => const NewsScreenWidget(),
    newsSearch: (context) => const SearchScreenWidget(),
    newsDetails: (context) => const NewsDetails(),
  };
}
