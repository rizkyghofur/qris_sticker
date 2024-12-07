import 'package:get/get.dart';

import '../controllers/add_edit_qris_controller.dart';

class AddEditQrisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditQrisController>(
      () => AddEditQrisController(),
    );
  }
}
