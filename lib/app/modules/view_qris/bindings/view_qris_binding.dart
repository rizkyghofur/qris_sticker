import 'package:get/get.dart';

import '../controllers/view_qris_controller.dart';

class ViewQrisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewQrisController>(
      () => ViewQrisController(),
    );
  }
}
