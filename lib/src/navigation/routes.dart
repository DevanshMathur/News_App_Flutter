import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/ui/search/search_screen.dart';


class Routes {
  Routes._();

  static const String newsSearch = '/search';
  static const String newsDetails = 'details';

  static final routes = <String, WidgetBuilder>{
    newsSearch: (BuildContext context) => const SearchScreen(),
    // newsDetails: (BuildContext context) => const NewsDetails(),
  };
}
