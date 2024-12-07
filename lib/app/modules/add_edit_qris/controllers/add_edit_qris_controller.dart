import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/qris_sticker_db_helper.dart';

class AddEditQrisController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final stickerTitleController = TextEditingController();
  final stickerInfoController = TextEditingController();
  final textValueController = TextEditingController();
  final isTextInput = true.obs;
  final imagePath = ''.obs;
  Uint8List? imageBytes;
  late String action;
  int? stickerId;

  final QrisStickerDbHelper _dbHelper = QrisStickerDbHelper();

  String get title => Get.arguments['action'] == 'add' ? 'Add' : 'Edit';

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      imageBytes = await File(pickedFile.path).readAsBytes();
      isTextInput.value = false;
    }
  }

  void saveSticker() async {
    if (formKey.currentState!.validate()) {
      final stickerData = {
        'id_qris': stickerId,
        'qris_name': stickerTitleController.text,
        'keterangan': stickerInfoController.text,
        'value': isTextInput.value ? textValueController.text : imagePath.value,
        'image': isTextInput.value ? null : imageBytes,
      };

      try {
        debugPrint('stickerData: $stickerData');
        if (title == 'Add') {
          await _dbHelper.saveQrisSticker(stickerData);
        } else {
          await _dbHelper.updateQrisSticker(stickerData);
        }
        debugPrint('success $title qris sticker');

        Get.back(result: stickerData);
      } catch (e) {
        Get.snackbar('Error', 'Failed to save QRIS Sticker: $e');
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    action = arguments?['action'] ?? 'add';

    if (action == 'edit') {
      final stickerData = arguments?['stickerData'] as Map<String, dynamic>?;
      if (stickerData != null) {
        stickerId = stickerData['id_qris'];
        stickerTitleController.text = stickerData['qris_name'];
        stickerInfoController.text = stickerData['keterangan'];
        if (stickerData['value'] != null && stickerData['image'] == null) {
          isTextInput.value = true;
          textValueController.text = stickerData['value'];
        } else if (stickerData['image'] != null) {
          isTextInput.value = false;
          imageBytes = stickerData['image'];
        }
      }
    }
  }

  @override
  void onClose() {
    stickerTitleController.dispose();
    stickerInfoController.dispose();
    textValueController.dispose();
    super.onClose();
  }
}
