import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_edit_qris_controller.dart';

class AddEditQrisView extends GetView<AddEditQrisController> {
  const AddEditQrisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.title} QRIS Sticker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.stickerTitleController,
                decoration: const InputDecoration(
                  labelText: 'Sticker Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sticker title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.stickerInfoController,
                decoration: const InputDecoration(
                  labelText: 'Information',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter information';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Obx(() {
                return Column(
                  children: [
                    RadioListTile<bool>(
                      title: const Text('Use Text as Value'),
                      value: true,
                      groupValue: controller.isTextInput.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.isTextInput.value = value;
                        }
                      },
                    ),
                    RadioListTile<bool>(
                      title: const Text('Use Image as Value'),
                      value: false,
                      groupValue: controller.isTextInput.value,
                      onChanged: (value) {
                        if (value != null) {
                          controller.isTextInput.value = value;
                        }
                      },
                    ),
                  ],
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.isTextInput.value) {
                  return TextFormField(
                    controller: controller.textValueController,
                    decoration: const InputDecoration(labelText: 'Text Value'),
                    validator: (value) => controller.isTextInput.value &&
                            (value == null || value.isEmpty)
                        ? 'Text value is required'
                        : null,
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.imageBytes == null
                          ? const Text('No image selected')
                          : Image.memory(
                              controller.imageBytes!,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: controller.pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text('Pick Image'),
                        ),
                      ),
                    ],
                  );
                }
              }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.saveSticker();
                    }
                  },
                  child: Text('${controller.title} Sticker'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
