import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../controllers/view_qris_controller.dart';

class ViewQrisView extends GetView<ViewQrisController> {
  const ViewQrisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QRIS Sticker Viewer'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Screenshot(
              controller: controller.screenshotController,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.qrisTitle,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (controller.imageBytes.isEmpty)
                      QrImageView(
                        data: controller.qrisValue,
                        size: 200,
                        version: QrVersions.auto,
                        gapless: false,
                      )
                    else
                      Image.memory(
                        controller.imageBytes,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    const SizedBox(height: 16),
                    Text(
                      controller.qrisInfo,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => controller.captureAndSaveQrCode(),
                icon: const Icon(Icons.save),
                label: const Text('Save as PNG'),
              ),
            ),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
