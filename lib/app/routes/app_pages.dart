import 'package:get/get.dart';

import '../../views/app_navigation/app_navigation_binding.dart';
import '../../views/app_navigation/app_navigation_view.dart';
import '../../views/change_language/change_language_binding.dart';
import '../../views/change_language/change_language_view.dart';
import '../../views/change_language_buttomsheet/change_language_buttomsheet_binding.dart';
import '../../views/change_language_buttomsheet/change_language_buttomsheet_view.dart';
import '../../views/change_password/change_password_binding.dart';
import '../../views/change_password/change_password_view.dart';
import '../../views/history_search/history_search_binding.dart';
import '../../views/history_search/history_search_view.dart';
import '../../views/invoce/invoce_binding.dart';
import '../../views/invoce/invoce_view.dart';
import '../../views/menu/menu_binding.dart';
import '../../views/menu/menu_view.dart';
import '../../views/next_point/next_point_binding.dart';
import '../../views/next_point/next_point_view.dart';
import '../../views/notification_center/notification_center_binding.dart';
import '../../views/notification_center/notification_center_view.dart';
import '../../views/search_post/search_post_binding.dart';
import '../../views/search_post/search_post_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = _Paths.APP_NAVIGATION_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.APP_NAVIGATION,
      page: () => const AppNavigationScreen(),
      binding: AppNavigationBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageScreen(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE_BUTTOMSHEET,
      page: () => ChangeListviewBottomsheet(),
      binding: ChangeLanguageButtomsheetBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_SEARCH,
      page: () => const HistorySearchView(),
      binding: HistorySearchBinding(),
    ),
    GetPage(
      name: _Paths.INVOCE,
      page: () => const InvoceView(),
      binding: InvoceBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => const MenuView(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.NEXT_POINT,
      page: () => const NextPointView(),
      binding: NextPointBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_CENTER,
      page: () => const NotificationCenterView(),
      binding: NotificationCenterBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_POST,
      page: () => const SearchPostView(),
      binding: SearchPostBinding(),
    ),
  ];
}
