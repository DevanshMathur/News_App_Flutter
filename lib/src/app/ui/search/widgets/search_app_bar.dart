import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final Function searchQuery;
  final TextEditingController queryTextController;

  const SearchAppBar(this.searchQuery, this.queryTextController, {Key? key})
      : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            // elevation: 5,
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(5)),),
            child: TextField(
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                widget.searchQuery();
              },
              cursorColor: Colors.white,
              decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter search text'),
              controller: widget.queryTextController,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.searchQuery();
            },
            child: const Icon(Icons.search_outlined),
          ),
        ],
      ),
    );
  }
}
