import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/ui/home/enum/dropdown_enum.dart';
import 'package:news_headlines/src/app_utils/app_preference.dart';
import 'package:news_headlines/src/app_utils/app_utils.dart';

class DropDownWidget extends StatefulWidget {
  final String _title;
  final DropDownEnum _dropDownEnum;

  final Function _callback;

  const DropDownWidget(this._title, this._dropDownEnum, this._callback,
      {Key? key})
      : super(key: key);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
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
                setValue(value!);
              });
            },
          ),
        )
      ],
    );
  }
  
  void setValue(String value) {
    switch (widget._dropDownEnum) {
      case DropDownEnum.categoryEnum:
        AppPreference.setSelectedCategory(value);
        break;
      case DropDownEnum.countryEnum:
        AppPreference.setSelectedCountry(value);
        break;
      case DropDownEnum.languageEnum:
        AppPreference.setSelectedLanguage(value);
        break;
      case DropDownEnum.themeEnum:
        AppPreference.setSelectedThemeEnum(AppUtils.getThemeEnum(value));
        break;
    }
    widget._callback(value);
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
