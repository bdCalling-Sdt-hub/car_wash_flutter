import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/auth/forgot_pass.dart';
import 'package:car_wash/presentation/screens/auth/login.dart';
import 'package:car_wash/presentation/screens/auth/reset_pass.dart';
import 'package:car_wash/presentation/screens/auth/sign_up.dart';
import 'package:car_wash/presentation/screens/auth/varification.dart';
import 'package:car_wash/presentation/screens/client/client_home/client_home.dart';
import 'package:car_wash/presentation/screens/client/req_service/req_service.dart';
import 'package:car_wash/presentation/screens/client/subscription/coupon.dart';
import 'package:car_wash/presentation/screens/client/subscription/my_subscription.dart';
import 'package:car_wash/presentation/screens/client/subscription/subscriptionlist.dart';
import 'package:car_wash/presentation/screens/language/choose_language.dart';
import 'package:car_wash/presentation/screens/splash_screen/splash_screen.dart';
import 'package:car_wash/presentation/screens/worker/worked_history/worked_history.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/worker_home.dart';
import 'package:car_wash/presentation/screens/worker/worker_notification/worker_notification.dart';
import 'package:car_wash/presentation/screens/worker/worker_profile/worker_profile.dart';
import 'package:car_wash/presentation/widgets/error_screen/error_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter initRoute = GoRouter(
      initialLocation: RoutePath.clientHome.addBasePath,
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
              AppRouter.route.replaceNamed(RoutePath.login);
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
            builder: (context, state) => LogInScreen()),

        ///======================= Forgot Pass Route =======================
        GoRoute(
            name: RoutePath.forgotPass,
            path: RoutePath.forgotPass.addBasePath,
            builder: (context, state) => ForgotPass()),

        ///======================= Reset Pass Route =======================
        GoRoute(
            name: RoutePath.resetPass,
            path: RoutePath.resetPass.addBasePath,
            builder: (context, state) => ResetPass()),

        ///======================= Varification Route =======================
        GoRoute(
            name: RoutePath.varification,
            path: RoutePath.varification.addBasePath,
            builder: (context, state) => VarificationScreen()),

        ///======================= Sign Up Route =======================

        GoRoute(
            name: RoutePath.signUp,
            path: RoutePath.signUp.addBasePath,
            builder: (context, state) => SignUpScreen()),

        ///======================= Choose Language =======================

        GoRoute(
            name: RoutePath.language,
            path: RoutePath.language.addBasePath,
            builder: (context, state) => ChooseLanguage()),

        /// <<<<<<<<<<<<<<======================= Worker Route =======================>>>>>>>>>>>>>>>>>>

        /// ==================== Worker Home ====================
        GoRoute(
            name: RoutePath.workerHome,
            path: RoutePath.workerHome.addBasePath,
            builder: (context, state) => WorkerHome()),

        /// ==================== Worker Profile ====================
        GoRoute(
            name: RoutePath.workerProfile,
            path: RoutePath.workerProfile.addBasePath,
            builder: (context, state) => WorkerProfile()),

        /// ==================== Order/Worked History ====================
        GoRoute(
            name: RoutePath.orderHistory,
            path: RoutePath.orderHistory.addBasePath,
            builder: (context, state) => const WorkedHistory()),

        /// ==================== Worker Notification ====================
        GoRoute(
            name: RoutePath.workerNotification,
            path: RoutePath.workerNotification.addBasePath,
            builder: (context, state) => const WorkerNotification()),

        /// ========================================== Client Section =====================================
        GoRoute(
            name: RoutePath.clientHome,
            path: RoutePath.clientHome.addBasePath,
            builder: (context, state) => ClientHome()),

        /// ==================== Client Service ===================

        GoRoute(
            name: RoutePath.mySubscription,
            path: RoutePath.mySubscription.addBasePath,
            builder: (context, state) => const ClientSubscription()),

        /// ==================== Subscription Packages ===================

        GoRoute(
            name: RoutePath.subscriptionPackages,
            path: RoutePath.subscriptionPackages.addBasePath,
            builder: (context, state) => const SubscriptionPackages()),

        /// ==================== Client Service Request ===================

        GoRoute(
            name: RoutePath.reqService,
            path: RoutePath.reqService.addBasePath,
            builder: (context, state) => const RequestService()),

        /// ==================== Client Service Request ===================

        GoRoute(
            name: RoutePath.coupon,
            path: RoutePath.coupon.addBasePath,
            builder: (context, state) => const CouponScreen()),
      ]);

  static GoRouter get route => initRoute;
}
