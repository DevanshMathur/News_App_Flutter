import 'package:flutter/material.dart';

import '../../theme/theme_enum.dart';
import 'app_preference.dart';

class AppUtils {
  static String? getSelectedCategoryCode() {
    String _selectedCategory = AppPreference.getSelectedCategory();
    if (_selectedCategory != 'All') {
      return _selectedCategory.toLowerCase();
    } else {
      return null;
    }
  }

  static String? getSelectedLanguageCode() {
    String _selectedLanguage = AppPreference.getSelectedLanguage();
    if (_selectedLanguage != 'All') {
      return _languageCodeList[
          _languageList.indexOf(AppPreference.getSelectedLanguage())];
    } else {
      return null;
    }
  }

  static String? getSelectedCountryCode() {
    String _selectedCountry = AppPreference.getSelectedCountry();
    if (_selectedCountry != 'All') {
      return _countryCodeList[
          _countryList.indexOf(AppPreference.getSelectedCountry())];
    } else {
      return null;
    }
  }

  static String getSelectedTheme() {
    switch (AppPreference.getSelectedThemeEnum()) {
      case ThemeEnum.lightTheme:
        return 'Light Theme';
      case ThemeEnum.darkTheme:
        return 'Dark Theme';
      case ThemeEnum.systemTheme:
        return 'System Theme';
    }
  }

  static ThemeEnum getThemeEnum(String value) {
    switch (value) {
      case 'Light Theme':
        return ThemeEnum.lightTheme;
      case 'Dark Theme':
        return ThemeEnum.darkTheme;
      case 'System Theme':
        return ThemeEnum.systemTheme;
      default:
        return ThemeEnum.systemTheme;
    }
  }

  static ThemeMode getSelectedThemeMode() {
    switch (AppPreference.getSelectedThemeEnum()) {
      case ThemeEnum.lightTheme:
        return ThemeMode.light;
      case ThemeEnum.darkTheme:
        return ThemeMode.dark;
      case ThemeEnum.systemTheme:
        return ThemeMode.system;
    }
  }

  static List<String> getThemeModeList() => _themeModeList;

  static List<String> getLanguageList() => _languageList;

  static List<String> getCategoryList() => _categoryList;

  static List<String> getCountryList() => _countryList;

  static final List<String> _themeModeList = [
    'Light Theme',
    'Dark Theme',
    'System Theme',
  ];

  static final List<String> _languageCodeList = [
    '',
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'he',
    'it',
    'nl',
    'no',
    'pt',
    'ru',
    'se',
    'ud',
    'zh'
  ];

  static final List<String> _countryCodeList = [
    '',
    'ae',
    'ar',
    'at',
    'au',
    'be',
    'bg',
    'br',
    'ca',
    'ch',
    'cn',
    'co',
    'cu',
    'cz',
    'de',
    'eg',
    'fr',
    'gb',
    'gr',
    'hk',
    'hu',
    'id',
    'ie',
    'il',
    'in',
    'it',
    'jp',
    'kr',
    'lt',
    'lv',
    'ma',
    'mx',
    'my',
    'ng',
    'nl',
    'no',
    'nz',
    'ph',
    'pl',
    'pt',
    'ro',
    'rs',
    'ru',
    'sa',
    'se',
    'sg',
    'si',
    'sk',
    'th',
    'tr',
    'tw',
    'ua',
    'us',
    've',
    'za'
  ];

  static final List<String> _categoryList = [
    'All',
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];

  static final List<String> _languageList = [
    'All',
    'Arabic',
    'German',
    'English',
    'Spanish',
    'French',
    'Hebrew',
    'Italian',
    'Dutch',
    'Norwegian',
    'Portuguese',
    'Russian',
    'se',
    'ud',
    'Chinese'
  ];

  static final List<String> _countryList = [
    'All',
    'United Arab Emirates',
    'Argentina',
    'Austria',
    'Australia',
    'Belgium',
    'Bulgaria',
    'Brazil',
    'Canada',
    'Switzerland',
    'China',
    'Colombia',
    'Cuba',
    'Czech Republic',
    'Germany',
    'Egypt',
    'France',
    'United Kingdom',
    'Greece',
    'Hong Kong',
    'Hungary',
    'Indonesia',
    'Ireland',
    'Israel',
    'India',
    'Italy',
    'Japan',
    'South Korea',
    'Lithuania',
    'Latvia',
    'Morocco',
    'Mexico',
    'Malaysia',
    'Nigeria',
    'Netherlands',
    'Norway',
    'New Zealand',
    'Philippines',
    'Poland',
    'Portugal',
    'Romania',
    'Serbia',
    'Russia',
    'Saudi Arabia',
    'Sweden',
    'Singapore',
    'Slovenia',
    'Slovakia',
    'Thailand',
    'Turkey',
    'Taiwan',
    'Ukraine',
    'United States',
    'Venezuela',
    'South Africa'
  ];
}
