part of 'services.dart';

class AuthServices {
  //
  static bool firstTimeOnApp() {
    return LocalStorageService.getBoolValue(AppStrings.firstTimeOnApp) ?? true;
  }

  static firstTimeCompleted() async {
    LocalStorageService.savedBoolValue(AppStrings.firstTimeOnApp, false);
  }

  //
  static bool authenticated() {
    return LocalStorageService.getBoolValue(AppStrings.authenticated) ?? false;
  }

  static Future<bool> isAuthenticated({bool force = true}) {
    return LocalStorageService.savedBoolValue(AppStrings.authenticated, force);
  }

  // Token
  static Future<String> getAuthBearerToken() async {
    return LocalStorageService.prefs!.getString(AppStrings.userAuthToken) ?? "";
  }

  static Future<String> getAuthFirebaseToken() async {
    return LocalStorageService.prefs!
            .getString(AppStrings.userAuthFirebaseToken) ??
        "";
  }

  static Future<bool> setAuthBearerToken(token) async {
    return LocalStorageService.prefs!
        .setString(AppStrings.userAuthToken, token);
  }

  static Future<bool> setAuthFirebaseToken(firebaseToken) async {
    return LocalStorageService.prefs!
        .setString(AppStrings.userAuthFirebaseToken, firebaseToken);
  }

  //Locale
  static String getLocale() {
    return LocalStorageService.prefs!.getString(AppStrings.appLocale) ?? "vi";
  }

  static Future<bool> setLocale(language) async {
    return LocalStorageService.prefs!.setString(AppStrings.appLocale, language);
  }

  static UserModel? currentUser;
  static Future<UserModel?> getCurrentUser({bool force = false}) async {
    if (currentUser == null || force) {
      final userStringObject =
          LocalStorageService.prefs!.getString(AppStrings.userKey);
      final userObject = json.decode(userStringObject ?? "{}");
      currentUser = UserModel.fromJson(userObject);
      // print("CurrentUser: ${currentUser!.}");
    }
    return currentUser;
  }

  // ///
  // ///
  // ///
  static Future<UserModel> saveUser(dynamic jsonObject) async {
    final currentUser = UserModel.fromJson(jsonObject);
    try {
      await LocalStorageService.prefs!.setString(
        AppStrings.userKey,
        json.encode(
          currentUser.toJson(),
        ),
      );
      if (AuthServices.currentUser == null) {
        AuthServices.currentUser = currentUser;
      }
      return currentUser;
    } catch (error) {
      print("saveUser error ==> $error");
      rethrow;
    }
  }

  static logout() async {
    await LocalStorageService.prefs!.clear();
    await LocalStorageService.prefs!.setBool(AppStrings.firstTimeOnApp, false);
  }
}
