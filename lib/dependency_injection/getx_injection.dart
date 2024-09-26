import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:get/get.dart';

void initGetx() {
  // ================== Auth Controller ==================
  Get.lazyPut(() => AuthController(), fenix: true);

  // ================================= Worker ======================================
  Get.lazyPut(() => WorkerHomeController(), fenix: true);
}
