
import 'package:get/get.dart';
import 'package:flutter_application_1/data/dao/barang_dao.dart';
import 'package:flutter_application_1/data/database/db_helper.dart';
import 'package:flutter_application_1/data/repo/barang_repo.dart';
import 'package:flutter_application_1/presentation/controller/barang_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DbHelper());

    Get.put(
      BarangDao(Get.find<DbHelper>()),
    );

    Get.put<BarangRepo>(
      BarangRepoImpl(Get.find<BarangDao>()),
    );

    Get.put(
      BarangController(Get.find<BarangRepo>()),
    );
  }
}
