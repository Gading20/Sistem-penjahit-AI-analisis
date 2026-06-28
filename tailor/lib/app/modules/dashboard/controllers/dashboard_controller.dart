// Copyright © 2026 Gading Ilham Saputra. All rights reserved.
// This code is proprietary and confidential. Unauthorized copying, modification,
// distribution, or use of this code is strictly prohibited without written permission.
import 'package:get/get.dart';
import '../../orders/controllers/orders_controller.dart';

class DashboardController extends GetxController {
  final currentIndex = 0.obs;

  void changePage(int index) {
    final previous = currentIndex.value;
    currentIndex.value = index;

    // Auto-refresh Orders tab (index 1) saat user navigasi ke sana
    if (index == 1 && previous != 1) {
      try {
        Get.find<OrdersController>().loadOrders();
      } catch (_) {}
    }
  }
}
