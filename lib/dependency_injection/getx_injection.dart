import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:get/get.dart';

void initGetx() {
  // ================== Auth Controller ==================
  Get.lazyPut(() => AuthController());
}
