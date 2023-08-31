import 'package:get/get.dart';
import 'package:pos_app/controllers/oders_controller.dart';

import 'presentation/screens/home.dart';

class BaseBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put<HomeController>(HomeController());
    Get.put(OrdersController());
  }
}

class AppRoutes {
  static const String initialRoute = '/';
  static const String homePageRoute = '/home';

  static List<GetPage> getPages = [
    GetPage(
      name: homePageRoute,
      page: () => HomePage(),
      binding: BaseBinding(),
    ),
  ];
}
