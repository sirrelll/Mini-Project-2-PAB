import 'package:get/get.dart';
import '../modules/auth/auth_controller.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/home/home_controller.dart';
import '../modules/home/home_view.dart';
import '../modules/form/form_controller.dart';
import '../modules/form/form_view.dart';
import '../modules/detail/detail_controller.dart';
import '../modules/detail/detail_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AuthController>(() => AuthController()),
      ),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<AuthController>(() => AuthController()),
      ),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<HomeController>(() => HomeController()),
      ),
    ),
    GetPage(
      name: AppRoutes.form,
      page: () => const FormView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<FormController>(() => FormController()),
      ),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailView(),
      binding: BindingsBuilder(
        () => Get.lazyPut<DetailController>(() => DetailController()),
      ),
    ),
  ];
}