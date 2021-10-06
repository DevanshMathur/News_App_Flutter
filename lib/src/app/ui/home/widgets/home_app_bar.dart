import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_headlines/src/navigation/routes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Top Headlines"),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, "/search");
              Navigator.pushNamed(context, Routes.newsSearch);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const SearchScreenWidget(),
              //   ),
              // );
            },
            child: const Icon(
              Icons.search_outlined,
            ),
          ),
        ),
      ],
    );
  }
}
