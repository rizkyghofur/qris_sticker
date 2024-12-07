import 'package:get/get.dart';

import '../modules/add_edit_qris/bindings/add_edit_qris_binding.dart';
import '../modules/add_edit_qris/views/add_edit_qris_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/view_qris/bindings/view_qris_binding.dart';
import '../modules/view_qris/views/view_qris_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EDIT_QRIS,
      page: () => const AddEditQrisView(),
      binding: AddEditQrisBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_QRIS,
      page: () => const ViewQrisView(),
      binding: ViewQrisBinding(),
    ),
  ];
}
