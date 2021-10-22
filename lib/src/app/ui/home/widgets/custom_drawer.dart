import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/ui/home/enum/dropdown_enum.dart';

import 'dropdown_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 10,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Settings",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: const [
                DropDownWidget("App Theme", DropDownEnum.themeEnum),
                DropDownWidget("News Category", DropDownEnum.categoryEnum),
                // DropDownWidget("News Language", DropDownEnum.languageEnum, updateList),
                DropDownWidget("News Country", DropDownEnum.countryEnum),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
