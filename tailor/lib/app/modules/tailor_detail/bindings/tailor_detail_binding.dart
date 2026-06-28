// Copyright © 2026 Gading Ilham Saputra. All rights reserved.
// This code is proprietary and confidential. Unauthorized copying, modification,
// distribution, or use of this code is strictly prohibited without written permission.
import 'package:get/get.dart';
import '../controllers/tailor_detail_controller.dart';

class TailorDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TailorDetailController>(() => TailorDetailController());
  }
}
