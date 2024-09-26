import 'package:get/get.dart';

import '../../views/add.income/bindings/add_income_binding.dart';
import '../../views/add.income/views/add_income_view.dart';
import '../../views/chat/bindings/chat_binding.dart';
import '../../views/chat/views/chat_view.dart';
import '../../views/expense/bindings/expense_binding.dart';
import '../../views/expense/views/expense_view.dart';
import '../../views/group/bindings/group_binding.dart';
import '../../views/group/views/group_view.dart';
import '../../views/home/bindings/home_binding.dart';
import '../../views/home/views/home_view.dart';
import '../../views/map/bindings/map_binding.dart';
import '../../views/map/views/map_view.dart';
import '../../views/onboarding/bindings/onboarding_binding.dart';
import '../../views/onboarding/views/onboarding_view.dart';
import '../../views/profile/bindings/profile_binding.dart';
import '../../views/profile/views/profile_view.dart';
import '../../views/setting/bindings/setting_binding.dart';
import '../../views/setting/views/setting_view.dart';
import '../../views/splash/bindings/splash_binding.dart';
import '../../views/splash/views/splash_view.dart';
import '../../views/total.expense/bindings/total_expense_binding.dart';
import '../../views/total.expense/views/total_expense_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
      children: [
        GetPage(
          name: _Paths.SPLASH,
          page: () => SplashView(),
          binding: SplashBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.GROUP,
      page: () => GroupView(),
      binding: GroupBinding(),
    ),
    GetPage(
      name: _Paths.EXPENSE,
      page: () => ExpenseView(),
      binding: ExpenseBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.TOTAL_EXPENSE,
      page: () => TotalExpenseView(),
      binding: TotalExpenseBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INCOME,
      page: () => AddIncomeView(),
      binding: AddIncomeBinding(),
    ),
  ];
}
