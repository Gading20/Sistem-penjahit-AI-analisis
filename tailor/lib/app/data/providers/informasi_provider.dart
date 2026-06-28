// Copyright © 2026 Gading Ilham Saputra. All rights reserved.
// This code is proprietary and confidential. Unauthorized copying, modification,
// distribution, or use of this code is strictly prohibited without written permission.
import 'api_provider.dart';

class InformasiProvider {
  static Future<Map<String, dynamic>> getPopuler() async {
    return ApiProvider.get('/api/informasi/populer');
  }

  static Future<Map<String, dynamic>> getTren() async {
    return ApiProvider.get('/api/informasi/tren');
  }

  static Future<Map<String, dynamic>> getRating() async {
    return ApiProvider.get('/api/informasi/rating');
  }
}
