// import 'package:flutter/material.dart';
// import 'package:kiwis_flutter/views/app_navigation/app_navigation_controller.dart';
// import '../../core/app_export.dart';

// class AppNavigationScreen extends GetWidget<AppNavigationController> {
//   const AppNavigationScreen({Key? key})
//       : super(
//           key: key,
//         );

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Color(0XFFFFFFFF),
//         body: SizedBox(
//           width: 375.h,
//           child: Column(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0XFFFFFFFF),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(height: 10.h),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.h),
//                       child: Text(
//                         "App Navigation",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0XFF000000),
//                           fontSize: 20.fSize,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Padding(
//                       padding: EdgeInsets.only(left: 20.h),
//                       child: Text(
//                         "Check your app's UI from the below demo screens of your app.",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Color(0XFF888888),
//                           fontSize: 16.fSize,
//                           fontFamily: 'Roboto',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.h),
//                     Divider(
//                       height: 1.h,
//                       thickness: 1.h,
//                       color: Color(0XFF000000),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(0XFFFFFFFF),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildScreenTitle(
//                           screenTitle: "social_sign_in",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.socialSignInScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "sign_up",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.signUpScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  select_location",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.selectLocationScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  sign_in",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.signInScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  welcome",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.welcomeScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  verification_email - BottomSheet",
//                           onTapScreenTitle: () => onTapBottomSheetTitle(
//                               context,
//                               VerificationEmailBottomsheet(
//                                   Get.put(VerificationEmailController()))),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  login_success - BottomSheet",
//                           onTapScreenTitle: () => onTapBottomSheetTitle(
//                               context,
//                               LoginSuccessBottomsheet(
//                                   Get.put(LoginSuccessController()))),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  search",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.searchScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  tour",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.tourScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  change_listview - BottomSheet",
//                           onTapScreenTitle: () => onTapBottomSheetTitle(
//                               context,
//                               ChangeListviewBottomsheet(
//                                   Get.put(ChangeListviewController()))),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  grid_view",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.gridViewScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  history_search",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.historySearchScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  tour_routing",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.tourRoutingScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  ratting",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.rattingScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  payment_stepThree",
//                           onTapScreenTitle: () => onTapScreenTitle(
//                               AppRoutes.paymentStepthreeScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  invoce",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.invoceScreen),
//                           Get.put(ShareTourController()),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  suggest_service_stepOne",
//                           onTapScreenTitle: () => onTapScreenTitle(
//                             AppRoutes.suggestServiceSteponeScreen,
//                           ),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  stepTwo",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.steptwoScreen),
//                         ),
//                         _buildScreenTitle(
//                           screenTitle: "  rating_step_Two",
//                           onTapScreenTitle: () =>
//                               onTapScreenTitle(AppRoutes.ratingStepTwoScreen),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Common click event for bottomsheet
//   void onTapBottomSheetTitle(
//     BuildContext context,
//     Widget className,
//   ) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return className;
//       },
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   /// Common widget
//   Widget _buildScreenTitle({
//     required String screenTitle,
//     Function? onTapScreenTitle,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         onTapScreenTitle?.call();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0XFFFFFFFF),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 10.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.h),
//               child: Text(
//                 screenTitle,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color(0XFF000000),
//                   fontSize: 20.fSize,
//                   fontFamily: 'Roboto',
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             SizedBox(height: 10.h),
//             SizedBox(height: 5.h),
//             Divider(
//               height: 1.h,
//               thickness: 1.h,
//               color: Color(0XFF888888),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   /// Common click event
//   void onTapScreenTitle(String routeName) {
//     Get.toNamed(routeName);
//   }
// }
