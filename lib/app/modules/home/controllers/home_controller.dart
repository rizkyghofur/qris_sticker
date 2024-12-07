import 'package:get/get.dart';

import '../../../utils/qris_sticker_db_helper.dart';

class HomeController extends GetxController {
  final QrisStickerDbHelper _dbHelper = QrisStickerDbHelper();
  var stickers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchStickers();
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }

  Future<void> fetchStickers() async {
    try {
      final allStickers = await _dbHelper.getAllQrisStickers();
      stickers.assignAll(allStickers);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch QRIS Stickers: $e');
    }
  }

  Future<Map<String, dynamic>> fetchQrisDataById(int id) async {
    try {
      return await _dbHelper.getQrisSticker(id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch QRIS Sticker ID $id: $e');
      return {};
    }
  }

  Future<void> deleteSticker(int id) async {
    try {
      await _dbHelper.deleteQrisSticker(id);
      Get.snackbar('Success', 'QRIS Sticker deleted successfully');
      fetchStickers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete QRIS Stickers: $e');
    }
  }

  Future<void> deleteAllStickers() async {
    try {
      await _dbHelper.deleteAllQrisSticker();
      Get.snackbar('Success', 'All QRIS Sticker deleted successfully');
      fetchStickers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch QRIS Stickers: $e');
    }
  }
}
