import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_bloc.dart';
import 'package:news_headlines/src/app/block/home/home_events.dart';
import 'package:news_headlines/src/app/block/theme/theme_bloc.dart';
import 'package:news_headlines/src/app/block/theme/theme_event.dart';
import 'package:news_headlines/src/app/ui/home/enum/dropdown_enum.dart';
import 'package:news_headlines/src/app_utils/app_preference.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';
import 'package:news_headlines/theme/enum/theme_enum.dart';

import '../news_home.dart';


class DropDownWidget extends StatefulWidget {
  final String _title;
  final DropDownEnum _dropDownEnum;

  const DropDownWidget(this._title, this._dropDownEnum, {Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget._title),
        SizedBox(
          width: 100,
          child: DropdownButton<String>(
            isExpanded: true,
            value: getActiveValue(),
            items: getItemList().map((value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,maxLines: 1,),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                setValue(value!, context);
              });
            },
          ),
        )
      ],
    );
  }

  void setValue(String value, BuildContext context) {
    switch (widget._dropDownEnum) {
      case DropDownEnum.categoryEnum:
        AppPreference.setSelectedCategory(value);
        updateList(value, context);
        break;
      case DropDownEnum.countryEnum:
        AppPreference.setSelectedCountry(value);
        updateList(value, context);
        break;
      case DropDownEnum.languageEnum:
        AppPreference.setSelectedLanguage(value);
        updateList(value, context);
        break;
      case DropDownEnum.themeEnum:
        switchTheme(value, context);
        break;
    }
  }

  void switchTheme(String value, BuildContext context) {
    ThemeEnum themeEnum = AppUtils.getThemeEnum(value);
    AppPreference.setSelectedThemeEnum(themeEnum);
    switch (themeEnum) {
      case ThemeEnum.lightTheme:
        BlocProvider.of<ThemeBloc>(context)
            .add(const ThemeEvent(themeMode: ThemeMode.light));
        break;
      case ThemeEnum.darkTheme:
        BlocProvider.of<ThemeBloc>(context)
            .add(const ThemeEvent(themeMode: ThemeMode.dark));
        break;
      case ThemeEnum.systemTheme:
        BlocProvider.of<ThemeBloc>(context)
            .add(const ThemeEvent(themeMode: ThemeMode.system));
        break;
    }
  }

  void updateList(String value, BuildContext context) {
    NewsHome.articleList.clear();
    BlocProvider.of<HomeBloc>(context).add(HomeFetchEvent(
        page: 0,
        country: AppUtils.getSelectedCountryCode(),
        category: AppUtils.getSelectedCategoryCode()));
    NewsHome.isLoading = true;
  }

  List<String> getItemList() {
    switch (widget._dropDownEnum) {
      case DropDownEnum.categoryEnum:
        return AppUtils.getCategoryList();
      case DropDownEnum.countryEnum:
        return AppUtils.getCountryList();
      case DropDownEnum.languageEnum:
        return AppUtils.getLanguageList();
      case DropDownEnum.themeEnum:
        return AppUtils.getThemeList();
    }
  }

  String getActiveValue() {
    switch (widget._dropDownEnum) {
      case DropDownEnum.categoryEnum:
        return AppPreference.getSelectedCategory();
      case DropDownEnum.countryEnum:
        return AppPreference.getSelectedCountry();
      case DropDownEnum.languageEnum:
        return AppPreference.getSelectedLanguage();
      case DropDownEnum.themeEnum:
        return AppUtils.getSelectedTheme();
    }
  }
}
