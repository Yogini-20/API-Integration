import 'package:api_integration/constant/routes.dart';
import 'package:get/get.dart';

import '../features/dashboard/dashboard_binding.dart';
import '../features/dashboard/dashboard_view.dart';
import '../features/forgot_password/update_binding.dart';
import '../features/forgot_password/update_view.dart';
import '../features/login/login_binding.dart';
import '../features/login/login_view.dart';
import '../features/signup/signUp_binding.dart';
import '../features/signup/signUp_view.dart';


List<GetPage> getPage = [
  GetPage(
      name: RoutesConstant.signupPage,
      page: () => const SignupView(),
      binding: SignupBinding()
  ),
  GetPage(
      name: RoutesConstant.loginPage,
      page: () => const LoginView(),
      binding: LoginBinding()
  ),
  GetPage(
      name: RoutesConstant.dashboardPage,
      page: () => const DashboardView(),
      binding: DashboardBinding()
  ),
  GetPage(
      name: RoutesConstant.updatePage,
      page: () => const UpdateView(),
      binding: UpdateBinding()
  ),
  // GetPage(
  //     name: RoutesConstant.profile,
  //     page: () => ProfileView(),
  //     binding: ProfileBinding()
  // ),
  // GetPage(
  //     name: RoutesConstant.navigate,
  //     page: () => const NavigateView(),
  //     binding: NavigateBinding()
  // ),
  // GetPage(
  //     name: RoutesConstant.reports,
  //     page: () => const ReportView(),
  //     binding: ReportBinding()
  // ),
];