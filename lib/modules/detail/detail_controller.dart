import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/film.dart';
import '../../routes/app_routes.dart';

class DetailController extends GetxController {
  final supabase = Supabase.instance.client;
  final RxBool isDeleting = false.obs;
  late Film film;

  @override
  void onInit() {
    super.onInit();
    film = Get.arguments;
  }

  void keEdit() async {
    final result = await Get.toNamed(AppRoutes.form, arguments: film);
    if (result == true) {
      Get.back(result: true);
    }
  }

  void konfirmasiHapus() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            child:
                const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(Get.overlayContext!).pop();
              await hapusFilm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
            ),
            child:
                const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> hapusFilm() async {
    try {
      isDeleting.value = true;
      await supabase.from('films').delete().eq('id', film.id!);
      Get.offAllNamed(AppRoutes.home);
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.snackbar(
          'Berhasil',
          'Film berhasil dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
    } catch (e) {
      isDeleting.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}