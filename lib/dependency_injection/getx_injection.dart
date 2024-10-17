import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/screens/client/client_home/controller/client_home_controller.dart';
import 'package:car_wash/presentation/screens/client/req_service/req_service_controller/req_service_controller.dart';
import 'package:car_wash/presentation/screens/client/subscription/controller/subscription_controller.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:car_wash/presentation/screens/profile/profile_controller/profile_controller.dart';

import 'package:get/get.dart';

void initGetx() {
  // ================== Global Controller ==================
  Get.lazyPut(() => ProfileController(), fenix: true);
  Get.lazyPut(() => GeneralController(), fenix: true);

  // ================== Auth Controller ==================
  Get.lazyPut(() => AuthController(), fenix: true);

  // ================================= Worker ======================================
  Get.lazyPut(() => WorkerHomeController(), fenix: true);

  // ================================= Client ======================================

  Get.lazyPut(() => ClientHomeController(), fenix: true);
  Get.lazyPut(() => ReqServiceController(), fenix: true);
  Get.lazyPut(() => SubscriptionController(), fenix: true);
}
