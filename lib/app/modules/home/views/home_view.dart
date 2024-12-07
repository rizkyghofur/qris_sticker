import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QRIS Sticker')),
      body: Obx(
        () {
          if (controller.stickers.isEmpty) {
            return const Center(child: Text('No QRIS stickers found.'));
          }

          return ListView.builder(
            itemCount: controller.stickers.length,
            itemBuilder: (context, index) {
              final sticker = controller.stickers[index];
              return ListTile(
                onTap: () {
                  controller
                      .fetchQrisDataById(sticker['id_qris'])
                      .then((result) {
                    Get.toNamed(
                      Routes.VIEW_QRIS,
                      arguments: {'action': 'view', 'stickerData': result},
                    );
                  });
                },
                title: Text(sticker['qris_name']),
                subtitle: Text(sticker['keterangan']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        controller
                            .fetchQrisDataById(sticker['id_qris'])
                            .then((result) {
                          Get.toNamed(
                            Routes.ADD_EDIT_QRIS,
                            arguments: {
                              'action': 'edit',
                              'stickerData': result
                            },
                          )!
                              .then((result) {
                            debugPrint('Result from Edit: $result');
                            if (result != null) {
                              Get.snackbar('Success',
                                  'QRIS Sticker updated successfully');
                              controller.fetchStickers();
                            }
                          });
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        controller.deleteSticker(sticker['id_qris']);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(
            Routes.ADD_EDIT_QRIS,
            arguments: {'action': 'add'},
          )!
              .then((result) {
            debugPrint('Result from Add: $result');
            if (result != null) {
              Get.snackbar('Success', 'QRIS Sticker added successfully');
              controller.fetchStickers();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
