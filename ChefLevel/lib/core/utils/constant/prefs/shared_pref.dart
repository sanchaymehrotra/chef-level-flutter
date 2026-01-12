import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String walkthroughKey = 'is_walkthrough_seen';
  static const String prefLevelKey = 'is_pref_level';
  static const String loggedInKey = 'is_logged_in';

  static const String deviceType = "device_type";
  static const String udid = "udid";
  static const String deviceId = "device_id";

  static const String sessionId = "session_id";
  static const String mmReqIdentifier = "device_id";
  static const String uid = "uid";
  static const String userIdKey = "userid";
  static const String pinKey = "pin";

  static const String dietaryList = "dietary_list";
  static const String favoriteCussineList = "favorite_cuisine_list";



  static Future<void> setWalkthroughSeen(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(walkthroughKey, value);
  }

  static Future<bool> isWalkthroughSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(walkthroughKey) ?? false;
  }

  static Future<void> setUDID(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(udid, value);
  }

  static Future<String> getUDID() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(udid) ?? "";
  }

  static Future<void> setDeviceType(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(deviceType, value);
  }

  static Future<String> getDeviceType() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(deviceType) ?? "";
  }

  static Future<void> setDeviceId(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(deviceId, value);
  }

  static Future<String> getDeviceId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(deviceId) ?? "";
  }

  static Future<void> setSessionID(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sessionId, value);
  }

  static Future<String> getSessionID() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionId) ?? "";
  }

  static Future<void> setIdentifier(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(mmReqIdentifier, value);
  }

  static Future<String> getIdentifier() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(mmReqIdentifier) ?? "";
  }

  static Future<void> setUid(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(uid, value);
  }

  static Future<String> getUid() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(uid) ?? "";
  }

  static Future<void> setPrefLevel(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(prefLevelKey, value);
  }

  static Future<bool> isPrefLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(prefLevelKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey) ?? false;
  }

  static Future<void> setUserId(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userIdKey, value);
  }

  static Future<String> getUserId() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey) ?? "";
  }

  static Future<void> setPin(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(pinKey, value);
  }

  static Future<String> getPin() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(pinKey) ?? "";
  }

  static Future<void> setFavoriteCuisineList(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(favoriteCussineList, value);
  }

  static Future<String> getFavoriteCuisineList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(favoriteCussineList) ?? "";
  }

  static Future<void> setDietaryList(String value) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(dietaryList, value);
  }

  static Future<String> getDietaryList() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(dietaryList) ?? "";
  }

  static Future<void> clearOnLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // OR clear only user/session related data
    // await prefs.remove(loggedInKey);
    // await prefs.remove(sessionId);
    // await prefs.remove(uid);
    // await prefs.remove(userIdKey);
    // await prefs.remove(pinKey);
    // await prefs.remove(prefLevelKey);
  }
}