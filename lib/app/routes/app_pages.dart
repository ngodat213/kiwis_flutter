import 'package:get/get.dart';

import '../../views/change_language/change_language_binding.dart';
import '../../views/change_language/change_language_view.dart';
import '../../views/change_listview_buttomsheet/change_language_buttomsheet_binding.dart';
import '../../views/change_listview_buttomsheet/change_language_buttomsheet_view.dart';
import '../../views/change_password/change_password_binding.dart';
import '../../views/change_password/change_password_view.dart';
import '../../views/detail_post/detail_post_binding.dart';
import '../../views/detail_post/detail_post_view.dart';
import '../../views/history_search/history_search_binding.dart';
import '../../views/history_search/history_search_view.dart';
import '../../views/home/home_binding.dart';
import '../../views/home/home_view.dart';
import '../../views/invoce/invoce_binding.dart';
import '../../views/invoce/invoce_view.dart';
import '../../views/main/main_binding.dart';
import '../../views/main/main_view.dart';
import '../../views/menu/menu_binding.dart';
import '../../views/menu/menu_view.dart';
import '../../views/message/message_binding.dart';
import '../../views/message/message_view.dart';
import '../../views/next_point/next_point_binding.dart';
import '../../views/next_point/next_point_view.dart';
import '../../views/notification_center/notification_center_binding.dart';
import '../../views/notification_center/notification_center_view.dart';
import '../../views/search_post/search_post_binding.dart';
import '../../views/search_post/search_post_view.dart';
import '../../views/sign_in/sign_in_binding.dart';
import '../../views/sign_in/sign_in_view.dart';
import '../../views/sign_up/sign_up_binding.dart';
import '../../views/sign_up/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SIGN_IN;

  static List<GetPage> routes = [
    GetPage(
      name: _Paths.DETAIL_POST,
      page: () => DetailPostScreen(),
      binding: DetailPostBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => ChangeLanguageScreen(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_LANGUAGE_BUTTOMSHEET,
      page: () => ChangeListviewBottomsheet(Get.find()),
      binding: ChangeListViewButtomsheetBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_SEARCH,
      page: () => const HistorySearchScreen(),
      binding: HistorySearchBinding(),
    ),
    GetPage(
      name: _Paths.INVOCE,
      page: () => const InvoceScreen(),
      binding: InvoceBinding(),
    ),
    GetPage(
      name: _Paths.MENU,
      page: () => MenuScreen(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.NEXT_POINT,
      page: () => const NextPointScreen(),
      binding: NextPointBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION_CENTER,
      page: () => const NotificationCenterScreen(),
      binding: NotificationCenterBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_POST,
      page: () => const SearchPostScreen(),
      binding: SearchPostBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => MessageView(),
      binding: MessageBinding(),
    ),
  ];
}
