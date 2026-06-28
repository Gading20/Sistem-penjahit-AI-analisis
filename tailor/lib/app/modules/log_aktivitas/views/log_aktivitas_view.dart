import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_colors.dart';
import '../controllers/log_aktivitas_controller.dart';

class LogAktivitasView extends GetView<LogAktivitasController> {
  const LogAktivitasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black.withValues(alpha: 0.07))],
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.textPrimary),
          ),
        ),
        title: Text(
          'Log Aktivitas',
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        if (controller.activities.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.history_rounded, size: 64, color: AppColors.textMuted.withValues(alpha: 0.5)),
                const SizedBox(height: 16),
                Text(
                  'Belum ada aktivitas',
                  style: GoogleFonts.poppins(fontSize: 16, color: AppColors.textMuted),
                ),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.fetch,
          child: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: controller.activities.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final a = controller.activities[i];
              return _ActivityCard(
                type: a['activity_type'] as String? ?? '',
                description: a['description'] as String? ?? '',
                createdAt: a['created_at'] as String? ?? '',
              );
            },
          ),
        );
      }),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String type;
  final String description;
  final String createdAt;

  const _ActivityCard({
    required this.type,
    required this.description,
    required this.createdAt,
  });

  IconData get _icon {
    switch (type) {
      case 'login':
        return Icons.login_rounded;
      case 'logout':
        return Icons.logout_rounded;
      case 'order':
        return Icons.receipt_long_rounded;
      default:
        return Icons.circle_outlined;
    }
  }

  Color get _color {
    switch (type) {
      case 'login':
        return const Color(0xFF34A853);
      case 'logout':
        return AppColors.error;
      case 'order':
        return AppColors.primary;
      default:
        return AppColors.textMuted;
    }
  }

  String get _label {
    switch (type) {
      case 'login':
        return 'Login';
      case 'logout':
        return 'Logout';
      case 'order':
        return 'Pesanan';
      default:
        return type;
    }
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final now = DateTime.now();
      final diff = now.difference(dt);
      if (diff.inMinutes < 1) return 'Baru saja';
      if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
      if (diff.inHours < 24) return '${diff.inHours} jam lalu';
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withValues(alpha: 0.04))],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: _color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_icon, color: _color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: _color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _label,
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: _color),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _formatDate(createdAt),
                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
