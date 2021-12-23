import 'package:logging/logging.dart';
import 'package:news_headlines/theme/enum/theme_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const _selectedTheme = "selectedTheme";
  static const _selectedCategory = "selectedCategory";
  static const _selectedCountry = "selectedCountry";
  static const _selectedLanguage = "selectedLanguage";

  static final Logger _log = Logger('AppPreference');



  static SharedPreferences? _instance;

  static Future getAppPrefInstance() async {
    try {
      _instance = await SharedPreferences.getInstance();
    } catch (e) {
      _log.log(Level.INFO, e.toString());
    }
  }

  static void setSelectedThemeEnum(ThemeEnum value) {
    _instance!.setInt(_selectedTheme, value.index);
  }

  static ThemeEnum getSelectedThemeEnum() {
    switch (_instance!.getInt(_selectedTheme) ?? 0) {
      case 0:
        return ThemeEnum.lightTheme;
      case 1:
        return ThemeEnum.darkTheme;
      case 2:
        return ThemeEnum.systemTheme;
      default:
        return ThemeEnum.systemTheme;
    }
  }

  static setSelectedCategory(String value) {
    _instance!.setString(_selectedCategory, value);
  }

  static String getSelectedCategory() {
    return _instance!.getString(_selectedCategory) ?? 'All';
  }

  static setSelectedCountry(String value) {
    _instance!.setString(_selectedCountry, value);
  }

  static String getSelectedCountry() {
    return _instance!.getString(_selectedCountry) ?? 'All';
  }

  static setSelectedLanguage(String value) {
    _instance!.setString(_selectedLanguage, value);
  }

  static String getSelectedLanguage() {
    return _instance!.getString(_selectedLanguage) ?? 'All';
  }
}
