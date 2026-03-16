import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'form_controller.dart';

class FormView extends GetView<FormController> {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0A0A0F) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          controller.isEdit ? 'Edit Film' : 'Tambah Film',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE50914).withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFE50914).withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.movie_creation_rounded,
                  color: Color(0xFFE50914),
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 28),

            _buildLabel('Judul Film', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              ctrl: controller.judulController,
              hint: 'Contoh: Avengers: Endgame',
              icon: Icons.title_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildLabel('Genre', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              ctrl: controller.genreController,
              hint: 'Contoh: Action, Sci-Fi',
              icon: Icons.category_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            _buildLabel('Sutradara', isDark),
            const SizedBox(height: 8),
            _buildTextField(
              ctrl: controller.sutradaraController,
              hint: 'Contoh: Christopher Nolan',
              icon: Icons.person_rounded,
              isDark: isDark,
            ),
            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: Obx(() => ElevatedButton(
                onPressed:
                    controller.isLoading.value ? null : controller.simpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50914),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        controller.isEdit
                            ? 'Simpan Perubahan'
                            : 'Tambah Film',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              )),
            ),
            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  'Batal',
                  style: TextStyle(
                    color: isDark ? Colors.grey : Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, bool isDark) {
    return Text(
      text,
      style: TextStyle(
        color: isDark ? Colors.white70 : Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController ctrl,
    required String hint,
    required IconData icon,
    required bool isDark,
  }) {
    return TextField(
      controller: ctrl,
      style: TextStyle(color: isDark ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
            color: isDark ? Colors.grey : Colors.grey[400]),
        prefixIcon: Icon(icon, color: const Color(0xFFE50914), size: 20),
        filled: true,
        fillColor: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: Color(0xFFE50914), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: isDark
                ? Colors.transparent
                : Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}