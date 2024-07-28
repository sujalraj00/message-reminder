import 'package:get/get.dart';
import 'package:message_reminder/controllers/login_controller.dart';
import 'package:message_reminder/res/routes/route_name.dart';
import 'package:message_reminder/res/screens/login_screen.dart';
import '../../controllers/onboarding_controller.dart';
import '../../controllers/splash_controller.dart';
import '../screens/onboarding.dart';
import '../screens/splash_page.dart';

class AppRoutes {
  static getRoutes() => [
    GetPage(
        name: RouteName.splash,
        page: () => const SplashPage(),
        binding: BindingsBuilder.put(() => SplashController())),

    GetPage(
        name: RouteName.onboarding,
        page: () => const OnBoarding(),
        binding: BindingsBuilder.put(() => OnBoardingController())),
    GetPage(
        name: RouteName.login,
        page: () => const LoginScreen(),
        binding: BindingsBuilder.put(() => LoginController()))
  ];
}
