import 'package:get/get.dart';

import '../../views/change_language/change_language_binding.dart';
import '../../views/change_language/change_language_view.dart';
import '../../views/change_password/change_password_binding.dart';
import '../../views/change_password/change_password_view.dart';
import '../../views/forgot_password/forgot_password_binding.dart';
import '../../views/forgot_password/forgot_password_view.dart';
import '../../views/home/home_binding.dart';
import '../../views/home/home_view.dart';
import '../../views/main/main_binding.dart';
import '../../views/main/main_view.dart';
import '../../views/message/message_binding.dart';
import '../../views/message/message_view.dart';
import '../../views/notification_center/notification_center_binding.dart';
import '../../views/notification_center/notification_center_view.dart';
import '../../views/on_plan/on_plan_binding.dart';
import '../../views/on_plan/on_plan_view.dart';
import '../../views/plan/plan_binding.dart';
import '../../views/plan/plan_view.dart';
import '../../views/saving_expense/saving_expense_binding.dart';
import '../../views/saving_expense/saving_expense_view.dart';
import '../../views/search_post/search_post_binding.dart';
import '../../views/search_post/search_post_view.dart';
import '../../views/sign_in/sign_in_binding.dart';
import '../../views/sign_in/sign_in_view.dart';
import '../../views/sign_up/sign_up_binding.dart';
import '../../views/sign_up/sign_up_view.dart';
import '../../views/splash/splash_binding.dart';
import '../../views/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static List<GetPage> routes = [
    GetPage(
      name: _Paths.CHANGE_LANGUAGE,
      page: () => ChangeLanguageScreen(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
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
      page: () => MessageScreen(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SAVING_EXPENSE,
      page: () => SavingExpenseView(),
      binding: SavingExpenseBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PLAN,
      page: () => PlanView(),
      binding: PlanBinding(),
    ),
    GetPage(
      name: _Paths.ON_PLAN,
      page: () => OnPlanView(),
      binding: OnPlanBinding(),
    ),
  ];
}
