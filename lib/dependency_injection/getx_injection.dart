import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:car_wash/global/profile_controller/profile_controller.dart';

import 'package:get/get.dart';

void initGetx() {
  // ================== Global Controller ==================
  Get.lazyPut(() => ProfileController(), fenix: true);

  // ================== Auth Controller ==================
  Get.lazyPut(() => AuthController(), fenix: true);

  // ================================= Worker ======================================
  Get.lazyPut(() => WorkerHomeController(), fenix: true);
}
