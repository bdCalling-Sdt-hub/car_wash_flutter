import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/auth/login.dart';
import 'package:car_wash/presentation/screens/splash_screen/splash_screen.dart';
import 'package:car_wash/presentation/widgets/error_screen/error_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
      initialLocation: RoutePath.splashScreen.addBasePath,
      // navigatorKey: Get.key,
      debugLogDiagnostics: true,
      routes: [
        ///======================= splash Route =======================

        GoRoute(
          name: RoutePath.splashScreen,
          path: RoutePath.splashScreen.addBasePath,
          builder: (context, state) => const SplashScreen(),
          redirect: (context, state) {
            Future.delayed(const Duration(seconds: 1), () {
              AppRouter.route.goNamed(RoutePath.login);
            });
            return null;
          },
        ),

        ///======================= Error Route =======================
        GoRoute(
            name: RoutePath.errorScreen,
            path: RoutePath.errorScreen.addBasePath,
            builder: (context, state) => const ErrorPage()),

        ///======================= LogIn Route =======================
        GoRoute(
            name: RoutePath.login,
            path: RoutePath.login.addBasePath,
            builder: (context, state) => const LogInScreen()),
      ]);

  static GoRouter get route => initRoute;
}
