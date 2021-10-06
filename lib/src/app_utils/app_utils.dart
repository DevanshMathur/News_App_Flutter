import 'package:flutter/material.dart';
import 'package:news_headlines/src/app/repository/news/api/model/article_source.dart';
import 'package:news_headlines/src/app/repository/news/api/model/news_article.dart';
import 'package:news_headlines/theme/app_theme.dart';

import 'app_preference.dart';

class AppUtils {
  // static String? _selectedCategory = 'All';
  // static String? _selectedLanguage = 'All';
  // static String? _selectedCountry = 'All';
  // static const bool _darkMode = false;

  static String? getSelectedCategoryCode() => getSelectedCategory() != 'All'
      ? getSelectedCategory().toLowerCase()
      : null;

  static void setSelectedCategory(String value) =>
      AppPreference.setSelectedCategory(value);

  static String getSelectedCategory() => AppPreference.getSelectedCategory();

  static String? getSelectedLanguageCode() => getSelectedLanguage() != 'All'
      ? _languageCodeList[_languageList.indexOf(getSelectedLanguage())]
      : null;

  static void setSelectedLanguage(String value) =>
      AppPreference.setSelectedLanguage(value);

  static String getSelectedLanguage() => AppPreference.getSelectedLanguage();

  static String? getSelectedCountryCode() => getSelectedCountry() != 'All'
      ? _countryCodeList[_countryList.indexOf(getSelectedCountry())]
      : null;

  static void setSelectedCountry(String value) =>
      AppPreference.setSelectedCountry(value);

  static String getSelectedCountry() => AppPreference.getSelectedCountry();

  static bool getDarkMode() => AppPreference.getDarkThemeEnabled();

  static void setDarkMode(bool value) =>
      AppPreference.setDarkThemeEnabled(value);

  static ThemeData getAppTheme() =>
      getDarkMode() ? AppTheme.darkTheme : AppTheme.lightTheme;

  static List<String> getLanguageList() => _languageList;

  static List<String> getCategoryList() => _categoryList;

  static List<String> getCountryList() => _countryList;

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

  static List<Article> newsList = [
    Article(
      Source(null, "BBC News"),
      "https://www.facebook.com/bbcnews",
      "Germany election: Merkel heir loses support as parties meet - BBC News",
      "Armin Laschet is facing mounting unrest within his party, after their historic election defeat.",
      "https://www.bbc.com/news/world-europe-58719080",
      "https://ichef.bbci.co.uk/news/1024/branded_news/52DC/production/_120721212_laschetsad.jpg",
      "2021-09-28T14:28:05Z",
      "By Paul KirbyBBC News, Berlin\r\nimage source, Getty Images\r\nimage caption, Armin Laschet has insisted that he can still form a government even though he lost\r\nGerman conservative leader Armin Laschet",
    ),
    Article(
      Source(null, "The Guardian"),
      "Dan Collyns",
      "‘Strategy of terror’: 116 dead as Ecuador prisons become battlegrounds for gangs - The Guardian",
      "Struggle between cartels to control smuggling routes leads to third – and deadliest – prison riot this year",
      "https://amp.theguardian.com/world/2021/sep/30/ecuador-prison-deaths-mexican-cartels",
      "https://i.guim.co.uk/img/media/938346a0db8c7f23eb030fe4dae9d06a4b9a9937/0_54_5170_3103/master/5170.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctZGVmYXVsdC5wbmc&enable=upscale&s=c738d41de924c17040913c2ad5b01cc4",
      "2021-09-30T16:01:00Z",
      "A bitter struggle between rival Mexican cartels to control cocaine trafficking routes in Ecuador has erupted in a day of bloodshed inside a high-security prison which left 116 inmates dead. Many of t… [+3822 chars]",
    ),
    Article(
      Source(null, "BBC News"),
      "https://www.facebook.com/bbcnews",
      "Germany election: Merkel heir loses support as parties meet - BBC News",
      "Armin Laschet is facing mounting unrest within his party, after their historic election defeat.",
      "https://www.bbc.com/news/world-europe-58719080",
      "https://ichef.bbci.co.uk/news/1024/branded_news/52DC/production/_120721212_laschetsad.jpg",
      "2021-09-28T14:28:05Z",
      "By Paul KirbyBBC News, Berlin\r\nimage source, Getty Images\r\nimage caption, Armin Laschet has insisted that he can still form a government even though he lost\r\nGerman conservative leader Armin Laschet",
    ),
    Article(
      Source(null, "The Guardian"),
      "Dan Collyns",
      "‘Strategy of terror’: 116 dead as Ecuador prisons become battlegrounds for gangs - The Guardian",
      "Struggle between cartels to control smuggling routes leads to third – and deadliest – prison riot this year",
      "https://amp.theguardian.com/world/2021/sep/30/ecuador-prison-deaths-mexican-cartels",
      "https://i.guim.co.uk/img/media/938346a0db8c7f23eb030fe4dae9d06a4b9a9937/0_54_5170_3103/master/5170.jpg?width=1200&height=630&quality=85&auto=format&fit=crop&overlay-align=bottom%2Cleft&overlay-width=100p&overlay-base64=L2ltZy9zdGF0aWMvb3ZlcmxheXMvdGctZGVmYXVsdC5wbmc&enable=upscale&s=c738d41de924c17040913c2ad5b01cc4",
      "2021-09-30T16:01:00Z",
      "A bitter struggle between rival Mexican cartels to control cocaine trafficking routes in Ecuador has erupted in a day of bloodshed inside a high-security prison which left 116 inmates dead. Many of t… [+3822 chars]",
    ),
  ];
}
