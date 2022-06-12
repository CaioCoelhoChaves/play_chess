import 'package:get/get_navigation/src/routes/get_route.dart';
import '../modules/game/game_binding.dart';
import '../modules/game/game_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import 'app_routes.dart';

class AppPages{
  AppPages._();

  static const initialRoute = AppRoutes.home;

  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.home, page: () => const HomeView(), binding: HomeBinding()),
    GetPage(name: AppRoutes.game, page: () => const GameView(), binding: GameBinding()),
  ];

}