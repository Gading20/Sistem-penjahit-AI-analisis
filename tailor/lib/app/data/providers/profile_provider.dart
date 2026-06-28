// Copyright © 2026 Gading Ilham Saputra. All rights reserved.
// This code is proprietary and confidential. Unauthorized copying, modification,
// distribution, or use of this code is strictly prohibited without written permission.
import 'api_provider.dart';
import '../models/user_model.dart';

class ProfileProvider {
  static Future<UserModel> getProfile() async {
    final result = await ApiProvider.get('/api/profile');
    return UserModel.fromJson(result['user']);
  }

  static Future<Map<String, dynamic>> updateProfile({String? name, String? phone}) async {
    final body = <String, dynamic>{};
    if (name != null) body['name'] = name;
    if (phone != null) body['phone'] = phone;
    return await ApiProvider.put('/api/profile', body: body);
  }

  static Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword) async {
    return await ApiProvider.put('/api/profile/password', body: {
      'old_password': oldPassword,
      'new_password': newPassword,
    });
  }

  static Future<List<Map<String, dynamic>>> getNotifications() async {
    final result = await ApiProvider.get('/api/notifications');
    return List<Map<String, dynamic>>.from(result['notifications'] ?? []);
  }
}
