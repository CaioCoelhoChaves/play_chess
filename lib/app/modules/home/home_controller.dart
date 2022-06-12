import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class HomeController extends GetxController{

  goTo2PlayersGame() => Get.toNamed(AppRoutes.game);

}