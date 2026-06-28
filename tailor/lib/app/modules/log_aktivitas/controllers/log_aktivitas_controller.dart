import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_provider.dart';

class LogAktivitasController extends GetxController {
  final activities = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    isLoading.value = true;
    try {
      final result = await ApiProvider.get('/api/aktivitas').timeout(
        const Duration(seconds: 15),
        onTimeout: () => {'_statusCode': 408, 'msg': 'Request timeout'},
      );
      if (result['_statusCode'] == 200 && result['data'] != null) {
        activities.value = List<Map<String, dynamic>>.from(result['data']);
      }
    } catch (e, st) {
      debugPrint('Fetch aktivitas error: $e $st');
    } finally {
      isLoading.value = false;
    }
  }
}
