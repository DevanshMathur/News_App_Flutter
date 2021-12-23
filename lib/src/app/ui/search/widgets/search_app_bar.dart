import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget {
  final Function searchQuery;
  final TextEditingController queryTextController;

  const SearchAppBar(this.searchQuery, this.queryTextController, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: TextField(
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                searchQuery();
              },
              cursorColor: Colors.white,
              decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter search text'),
              controller: queryTextController,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              searchQuery();
            },
            child: const Icon(Icons.search_outlined),
          ),
        ],
      ),
    );
  }
}
