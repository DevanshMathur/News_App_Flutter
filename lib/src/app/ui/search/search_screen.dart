import 'package:flutter/material.dart';
import 'package:news_headlines/src/constants/app_utils.dart';

import '../widgets/news_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News Hunt"),
      ),
      body: ListView.builder(
          itemCount: AppUtils.newsList.length,
          itemBuilder: (context, position) {
            return Card(
              elevation: 10,
              margin: const EdgeInsets.all(5),
              child: NewsItem(AppUtils.newsList[position]),
            );
          }
      ),
    );
  }
}
