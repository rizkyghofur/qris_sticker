import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:screenshot/screenshot.dart';

class ViewQrisController extends GetxController {
  final ScreenshotController screenshotController = ScreenshotController();

  String randomQrisDate = '';
  late String qrisId;
  late String qrisTitle;
  late String qrisInfo;
  late String qrisValue;
  late Uint8List imageBytes;

  @override
  void onInit() {
    super.onInit();

    randomQrisDate = DateTime.now().millisecondsSinceEpoch.toString();

    final Map<String, dynamic> stickerData = Get.arguments['stickerData'] ?? {};
    qrisId = stickerData['id_qris'].toString();
    qrisTitle = stickerData['qris_name'] ?? 'No Title';
    qrisInfo = stickerData['keterangan'] ?? 'No Information';
    qrisValue = stickerData['value'] ?? '';
    String imageBase64String = stickerData['image'] ?? '';
    imageBytes = base64Decode(imageBase64String);
  }

  Future<void> saveQrCode(Uint8List imageBytes) async {
    try {
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: "qris_sticker_$qrisId-$randomQrisDate",
      );

      if (result != null && result['isSuccess'] == true) {
        Get.snackbar(
          'Success',
          'QR code saved to gallery/photos.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception('Failed to save the image to gallery/photos.');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save QR code: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> captureAndSaveQrCode() async {
    try {
      final imageBytes = await screenshotController.capture(
        delay: const Duration(milliseconds: 10),
      );
      if (imageBytes != null) {
        await saveQrCode(imageBytes);
      } else {
        Get.snackbar(
          'Error',
          'Failed to capture QR code',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
