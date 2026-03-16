import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../routes/app_routes.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxBool obscurePassword = true.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void _tampilkanDialog(String judul, String pesan,
      {bool tawariRegister = false}) {
    if (isLoading.value) isLoading.value = false;
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFFE50914)),
            const SizedBox(width: 8),
            Text(judul, style: const TextStyle(color: Colors.white)),
          ],
        ),
        content: Text(pesan, style: const TextStyle(color: Colors.grey)),
        actions: [
          if (tawariRegister) ...[
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Batal',
                  style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                Get.toNamed(AppRoutes.register);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Daftar Sekarang',
                  style: TextStyle(color: Colors.white)),
            ),
          ] else
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Coba Lagi',
                  style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> login() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email == '' || password == '') {
      _tampilkanDialog('Peringatan', 'Email dan password harus diisi!');
      return;
    }

    isLoading.value = true;

    try {
      final response = await supabase.auth
          .signInWithPassword(email: email, password: password)
          .timeout(const Duration(seconds: 10));
      isLoading.value = false;
      if (response.user != null) {
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      isLoading.value = false;
      String pesan = e.toString().toLowerCase();
      if (pesan.contains('invalid') ||
          pesan.contains('not found') ||
          pesan.contains('credentials') ||
          pesan.contains('user')) {
        _tampilkanDialog(
          'Akun Tidak Ditemukan',
          'Akun belum terdaftar atau password salah. Daftar terlebih dahulu?',
          tawariRegister: true,
        );
      } else if (pesan.contains('timeout')) {
        _tampilkanDialog('Koneksi Bermasalah',
            'Koneksi timeout, periksa internet kamu.');
      } else {
        _tampilkanDialog('Login Gagal',
            'Terjadi kesalahan, silakan coba lagi.');
      }
    }
  }

  Future<void> register() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();

    if (email == '' || password == '') {
      _tampilkanDialog('Peringatan', 'Email dan password harus diisi!');
      return;
    }

    if (password.length < 6) {
      _tampilkanDialog('Peringatan', 'Password minimal 6 karakter!');
      return;
    }

    isLoading.value = true;

    try {
      final response = await supabase.auth
          .signUp(email: email, password: password)
          .timeout(const Duration(seconds: 10));
      isLoading.value = false;
      if (response.user != null) {
        Get.offAllNamed(AppRoutes.home);
      }
    } catch (e) {
      isLoading.value = false;
      String pesan = e.toString().toLowerCase();
      if (pesan.contains('already')) {
        _tampilkanDialog(
            'Email Sudah Terdaftar', 'Gunakan email lain atau langsung login.');
      } else if (pesan.contains('timeout')) {
        _tampilkanDialog('Koneksi Bermasalah',
            'Koneksi timeout, periksa internet kamu.');
      } else {
        _tampilkanDialog('Register Gagal',
            'Terjadi kesalahan, silakan coba lagi.');
      }
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  void togglePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
}