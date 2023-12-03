import 'package:eatery/components/custom_color.dart';
import 'package:eatery/features/auth/auth_provider.dart';
import 'package:eatery/features/auth/auth_repository.dart';
import 'package:eatery/resources/resources.dart';
import 'package:eatery/router.dart';
import 'package:eatery/services/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final _authRepository = getIt.get<AuthRepository>();
final _authProvider = ChangeNotifierProvider<AuthProvider>(
    (ref) => AuthProvider(_authRepository));

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = ref.read(_authProvider);

      final state = authProvider.userLoginState();
      if (state) {
        context.goNamed(RoutesName.home);
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          context.pushNamed(RoutesName.auth);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Image.asset(
                  Images.eateryPng,
                  width: constraints.maxWidth >= 480 ? 500 : 200,
                  height: constraints.maxWidth >= 480 ? 500 : 200,
                ),
              ),
              const Spacer(),
              const Center(
                  child: SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: EateryColor.main,
                      ))),
              const SizedBox(
                height: 25,
              )
            ],
          ),
        );
      }),
    );
  }
}
