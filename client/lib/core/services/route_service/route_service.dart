import 'package:donardiary/core/common_providers/auth_state_provider.dart';
import 'package:donardiary/core/constants/route_names.dart';
import 'package:donardiary/features/auth/view/login_screen.dart';
import 'package:donardiary/features/auth/view/register_screen.dart';
import 'package:donardiary/features/home/view/home_screen.dart';
import 'package:donardiary/features/splash/view/splash_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(routes: [
    GoRoute(
        path: "/",
        name: RouteNames.splashScreen,
        builder: (context, state) {
          // Access the provider using context.read
          return const SplashScreen();
        }),
    GoRoute(
        path: "/login",
        name: RouteNames.login,
        builder: (context, state) {
          // Access the provider using context.read
          return const LoginScreen();
        }),
    GoRoute(
        path: "/register",
        name: RouteNames.register,
        builder: (context, state) {
          // Access the provider using context.read
          return const RegisterScreen();
        }),
    GoRoute(
        path: "/home",
        name: RouteNames.home,
        builder: (context, state) {
          return  HomeScreen();
        }),
  ]);
});
