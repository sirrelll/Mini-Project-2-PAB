import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/film.dart';
import '../../routes/app_routes.dart';

class HomeController extends GetxController {
  final supabase = Supabase.instance.client;
  final RxList<Film> daftarFilm = <Film>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ambilSemuaFilm();
  }

  Future<void> ambilSemuaFilm() async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('films')
          .select()
          .order('id', ascending: false);
      daftarFilm.value =
          (response as List).map((e) => Film.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void konfirmasiHapus(int id) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus Film?',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Film ini akan dihapus dari daftar favorit.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Batal',
                style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(Get.overlayContext!).pop();
              await hapusFilm(id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
            ),
            child: const Text('Hapus',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> hapusFilm(int id) async {
    try {
      await supabase.from('films').delete().eq('id', id);
      daftarFilm.removeWhere((f) => f.id == id);
      Get.snackbar(
        'Berhasil',
        'Film berhasil dihapus',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void keTambah() async {
    final result = await Get.toNamed(AppRoutes.form);
    if (result == true) ambilSemuaFilm();
  }

  void keEdit(Film film) async {
    final result = await Get.toNamed(AppRoutes.form, arguments: film);
    if (result == true) ambilSemuaFilm();
  }

  void keDetail(Film film) async {
    final result = await Get.toNamed(AppRoutes.detail, arguments: film);
    if (result == true) ambilSemuaFilm();
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
    Get.offAllNamed(AppRoutes.login);
  }
}