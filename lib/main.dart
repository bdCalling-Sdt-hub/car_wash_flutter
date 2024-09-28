import 'package:car_wash/core/routes/routes.dart';
import 'package:car_wash/core/theme/light_theme.dart';
import 'package:car_wash/dependency_injection/getx_injection.dart';
import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/utils/system_utils/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  SystemUtil.setStatusBarColor(color: Colors.transparent);
  initGetx();
  initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      // splitScreenMode: true,
      builder: (context, child) => GetMaterialApp.router(
        debugShowCheckedModeBanner: false,
        //title: 'IHB',
        theme: lightTheme,
        // darkTheme:CustomTheme.darkTheme, // standard dark theme
        //themeMode: lightTheme,
        routeInformationParser: AppRouter.route.routeInformationParser,
        routerDelegate: AppRouter.route.routerDelegate,
        routeInformationProvider: AppRouter.route.routeInformationProvider,
      ),
    );
  }
}
