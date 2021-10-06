import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  static const _darkThemeEnabled = "darkThemeEnabled";
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

  static setDarkThemeEnabled(bool val) {
    _instance!.setBool(_darkThemeEnabled, val);
  }

  static bool getDarkThemeEnabled() {
    return _instance!.getBool(_darkThemeEnabled) ?? false;
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

  /*
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('stringValue', "abc");
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('boolValue', true);
  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('stringValue');
    return stringValue;
  }

  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('boolValue');
    return boolValue;
  }
   */
}
