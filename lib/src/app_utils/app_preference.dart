import 'package:logging/logging.dart';
import 'package:news_headlines/theme/theme_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const _selectedTheme = "selectedTheme";
  static const _selectedCategory = "selectedCategory";
  static const _selectedCountry = "selectedCountry";
  static const _selectedLanguage = "selectedLanguage";

  static final Logger _log = Logger('AppPreference');

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static SharedPreferences? _instance;

  static Future getAppPrefInstance() async {
    try {
      _instance = await _prefs;
    } catch (e) {
      _log.log(Level.INFO, e.toString());
    }
  }

  static void setSelectedThemeEnum(ThemeEnum val) {
    _instance!.setInt(_selectedTheme, val.index);
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

  static setSelectedCategory(String val) {
    _instance!.setString(_selectedCategory, val);
  }

  static String getSelectedCategory() {
    return _instance!.getString(_selectedCategory) ?? 'All';
  }

  static setSelectedCountry(String val) {
    _instance!.setString(_selectedCountry, val);
  }

  static String getSelectedCountry() {
    return _instance!.getString(_selectedCountry) ?? 'All';
  }

  static setSelectedLanguage(String val) {
    _instance!.setString(_selectedLanguage, val);
  }

  static String getSelectedLanguage() {
    return _instance!.getString(_selectedLanguage) ?? 'All';
  }
}
