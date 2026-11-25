
import 'package:get/get.dart';
import 'package:flutter_application_1/data/repo/barang_repo.dart';
import 'package:flutter_application_1/model/barang.dart';

class BarangController extends GetxController {
  final BarangRepo repo;

  BarangController(this.repo);

  var barangList = <Barang>[].obs;

  @override
  void onInit() {
    super.onInit();
    getBarang();
  }

  // READ
  Future<void> getBarang() async {
    try {
      barangList.value = await repo.getAllBarang();
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengambil data');
    }
  }

  // CREATE
  Future<void> tambahBarang(Barang barang) async {
    try {
      await repo.insert(barang);
      await getBarang();

      Get.snackbar('Sukses', 'Barang berhasil ditambahkan');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan barang');
    }
  }

  // UPDATE
  Future<void> updateBarang(Barang barang) async {
    try {
      await repo.update(barang);
      await getBarang();

      Get.snackbar('Sukses', 'Barang berhasil diubah');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengubah barang');
    }
  }

  // DELETE
  Future<void> hapusBarang(int id) async {
    try {
      await repo.delete(id);
      await getBarang();

      Get.snackbar('Sukses', 'Barang berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus barang');
    }
  }
}
