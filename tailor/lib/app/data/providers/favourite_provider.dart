// Copyright © 2026 Gading Ilham Saputra. All rights reserved.
// This code is proprietary and confidential. Unauthorized copying, modification,
// distribution, or use of this code is strictly prohibited without written permission.
import 'api_provider.dart';
import '../models/tailor_model.dart';

class FavouriteProvider {
  static Future<List<TailorModel>> getFavourites() async {
    final result = await ApiProvider.get('/api/favourites');
    final list = result['favourites'] as List? ?? [];
    return list
        .map((e) => TailorModel.fromJson(e['tailor'] as Map<String, dynamic>))
        .toList();
  }

  static Future<Map<String, dynamic>> addFavourite(int tailorId) async {
    return ApiProvider.post('/api/favourites/$tailorId');
  }

  static Future<Map<String, dynamic>> removeFavourite(int tailorId) async {
    return ApiProvider.delete('/api/favourites/$tailorId');
  }
}
