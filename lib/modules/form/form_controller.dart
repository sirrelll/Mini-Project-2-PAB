import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/film.dart';

class FormController extends GetxController {
  final supabase = Supabase.instance.client;
  final judulController = TextEditingController();
  final genreController = TextEditingController();
  final sutradaraController = TextEditingController();
  final RxBool isLoading = false.obs;
  Film? filmEdit;

  bool get isEdit => filmEdit != null;

  @override
  void onInit() {
    super.onInit();
    filmEdit = Get.arguments;
    if (isEdit) {
      judulController.text = filmEdit!.judul;
      genreController.text = filmEdit!.genre;
      sutradaraController.text = filmEdit!.sutradara;
    }
  }

  @override
  void onClose() {
    judulController.dispose();
    genreController.dispose();
    sutradaraController.dispose();
    super.onClose();
  }

  Future<void> simpan() async {
    String judul = judulController.text.toString().trim();
    String genre = genreController.text.toString().trim();
    String sutradara = sutradaraController.text.toString().trim();

    if (judul == '' || genre == '' || sutradara == '') {
      Get.snackbar(
        'Peringatan',
        'Semua field harus diisi!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading.value = true;
      final film = Film(judul: judul, genre: genre, sutradara: sutradara);

      if (isEdit) {
        await supabase
            .from('films')
            .update(film.toJson())
            .eq('id', filmEdit!.id!);
      } else {
        await supabase.from('films').insert(film.toJson());
      }

      Get.back(result: true);

      Future.delayed(const Duration(milliseconds: 300), () {
        Get.snackbar(
          'Berhasil',
          isEdit ? 'Film berhasil diperbarui' : 'Film berhasil ditambahkan',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      });
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
}