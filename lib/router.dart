import 'package:bot_toast/bot_toast.dart';
import 'package:eatery/ui/auth/login_view.dart';
import 'package:eatery/ui/auth/password_reset_view.dart';
import 'package:eatery/ui/auth/register_view.dart';
import 'package:eatery/ui/home/index.dart';
import 'package:eatery/ui/onboard/splash_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesName {
  static const String initialRoute = '/';
  static const String auth = '/auth';
  static const String home = '/index';
  static const String register = '/register';
  static const String passwordReset = '/password-reset';
}

final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    observers: [BotToastNavigatorObserver()],
    initialLocation: RoutesName.initialRoute,
    routes: <GoRoute>[
      GoRoute(
          path: '/',
          name: RoutesName.initialRoute,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const SplashView(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          }),
      GoRoute(
          path: '/auth',
          name: RoutesName.auth,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const LoginView(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          },
          routes: [
            GoRoute(
                path: 'register',
                name: RoutesName.register,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const RegisterView(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      );
                    },
                  );
                }),
            GoRoute(
                path: 'password-reset',
                name: RoutesName.passwordReset,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: const PasswordResetView(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      // Change the opacity of the screen using a Curve based on the the animation's
                      // value
                      return FadeTransition(
                        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                        child: child,
                      );
                    },
                  );
                }),
          ]),
      GoRoute(
          path: '/index',
          name: RoutesName.home,
          pageBuilder: (BuildContext context, GoRouterState state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const IndexView(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Change the opacity of the screen using a Curve based on the the animation's
                // value
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                  child: child,
                );
              },
            );
          }),
    ]);
