import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String title;
  final bool isLoading;

  const CustomLoader(this.title, this.isLoading, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? const Padding(
                  padding: EdgeInsets.all(5), child: CircularProgressIndicator())
              : Container(),
          Text(title),
        ],
      ),
    );
  }
}
